QBCore.Functions = {}

-- Getters
-- Get your player first and then trigger a function on them
-- ex: local player = QBCore.Functions.GetPlayer(source)
-- ex: local example = player.Functions.functionname(parameter)

function QBCore.Functions.GetCoords(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return vector4(coords.x, coords.y, coords.z, heading)
end

function QBCore.Functions.GetIdentifier(source, idtype)
    local src = source
    local idtype = idtype or QBConfig.IdentifierType
    for _, identifier in pairs(GetPlayerIdentifiers(src)) do
        if string.find(identifier, idtype) then
            return identifier
        end
    end
    return nil
end

function QBCore.Functions.GetSource(identifier)
    for src, player in pairs(QBCore.Players) do
        local idens = GetPlayerIdentifiers(src)
        for _, id in pairs(idens) do
            if identifier == id then
                return src
            end
        end
    end
    return 0
end

function QBCore.Functions.GetPlayer(source)
    local src = source
    if type(src) == 'number' then
        return QBCore.Players[src]
    else
        return QBCore.Players[QBCore.Functions.GetSource(src)]
    end
end

function QBCore.Functions.GetPlayerByCitizenId(citizenid)
    for src, player in pairs(QBCore.Players) do
        local cid = citizenid
        if QBCore.Players[src].PlayerData.citizenid == cid then
            return QBCore.Players[src]
        end
    end
    return nil
end

function QBCore.Functions.GetPlayerByPhone(number)
    for src, player in pairs(QBCore.Players) do
        local cid = citizenid
        if QBCore.Players[src].PlayerData.charinfo.phone == number then
            return QBCore.Players[src]
        end
    end
    return nil
end

function QBCore.Functions.GetPlayers()
    local sources = {}
    for k, v in pairs(QBCore.Players) do
        sources[#sources+1] = k
    end
    return sources
end

-- Will return an array of QB Player class instances
-- unlike the GetPlayers() wrapper which only returns IDs
function QBCore.Functions.GetQBPlayers()
    return QBCore.Players
end

--- Gets a list of all on duty players of a specified job and the number
function QBCore.Functions.GetPlayersOnDuty(job)
    local players = {}
    local count = 0

    for src, Player in pairs(QBCore.Players) do
        if Player.PlayerData.job.name == job then
            if Player.PlayerData.job.onduty then
                players[#players + 1] = src
                count = count + 1
            end
        end
    end
    return players, count
end

-- Returns only the amount of players on duty for the specified job
function QBCore.Functions.GetDutyCount(job)
    local count = 0

    for _, Player in pairs(QBCore.Functions.GetQBPlayers()) do
        if Player.PlayerData.job.name == job then
            if Player.PlayerData.job.onduty then
                count = count + 1
            end
        end
    end
    return count
end

-- Paychecks (standalone - don't touch)

function PaycheckLoop()
    local Players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(Players) do
        local payment = Player.PlayerData.job.payment
        if Player.PlayerData.job and Player.PlayerData.job.onduty and payment > 0 then
            Player.Functions.AddMoney('bank', payment)
            TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, ('You received your paycheck of $%s'):format(payment))
        end
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckLoop)
end

-- Callbacks

function QBCore.Functions.CreateCallback(name, cb)
    QBCore.ServerCallbacks[name] = cb
end

function QBCore.Functions.TriggerCallback(name, source, cb, ...)
    local src = source
    if QBCore.ServerCallbacks[name] then
        QBCore.ServerCallbacks[name](src, cb, ...)
    end
end

-- Items

function QBCore.Functions.CreateUseableItem(item, cb)
    QBCore.UseableItems[item] = cb
end

function QBCore.Functions.CanUseItem(item)
    return QBCore.UseableItems[item]
end

function QBCore.Functions.UseItem(source, item)
    local src = source
    QBCore.UseableItems[item.name](src, item)
end

-- Kick Player

function QBCore.Functions.Kick(source, reason, setKickReason, deferrals)
    local src = source
    reason = '\n' .. reason .. '\n🔸 Check our Discord for further information: ' .. QBCore.Config.Server.discord
    if setKickReason then
        setKickReason(reason)
    end
    CreateThread(function()
        if deferrals then
            deferrals.update(reason)
            Wait(2500)
        end
        if src then
            DropPlayer(src, reason)
        end
        local i = 0
        while (i <= 4) do
            i = i + 1
            while true do
                if src then
                    if (GetPlayerPing(src) >= 0) then
                        break
                    end
                    Wait(100)
                    CreateThread(function()
                        DropPlayer(src, reason)
                    end)
                end
            end
            Wait(5000)
        end
    end)
end

-- Check if player is whitelisted (not used anywhere)

function QBCore.Functions.IsWhitelisted(source)
    local src = source
    local plicense = QBCore.Functions.GetIdentifier(src, 'license')
    local identifiers = GetPlayerIdentifiers(src)
    if QBCore.Config.Server.whitelist then
        local result = exports.oxmysql:executeSync('SELECT * FROM whitelist WHERE license = ?', { plicense })
        if result[1] then
            for _, id in pairs(identifiers) do
                if result[1].license == id then
                    return true
                end
            end
        end
    else
        return true
    end
    return false
end

-- Setting & Removing Permissions

function QBCore.Functions.AddPermission(source, permission)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local plicense = Player.PlayerData.license
    if Player then
        QBCore.Config.Server.PermissionList[plicense] = {
            license = plicense,
            permission = permission:lower(),
        }
        exports.oxmysql:execute('DELETE FROM permissions WHERE license = ?', { plicense })

        exports.oxmysql:insert('INSERT INTO permissions (name, license, permission) VALUES (?, ?, ?)', {
            GetPlayerName(src),
            plicense,
            permission:lower()
        })

        Player.Functions.UpdatePlayerData()
        TriggerClientEvent('QBCore:Client:OnPermissionUpdate', src, permission)
    end
end

function QBCore.Functions.RemovePermission(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local license = Player.PlayerData.license
    if Player then
        QBCore.Config.Server.PermissionList[license] = nil
        exports.oxmysql:execute('DELETE FROM permissions WHERE license = ?', { license })
        Player.Functions.UpdatePlayerData()
    end
end

-- Checking for Permission Level

function QBCore.Functions.HasPermission(source, permission)
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local permission = tostring(permission:lower())
    if permission == 'user' then
        return true
    else
        if QBCore.Config.Server.PermissionList[license] then
            if QBCore.Config.Server.PermissionList[license].license == license then
                if QBCore.Config.Server.PermissionList[license].permission == permission or QBCore.Config.Server.PermissionList[license].permission == 'god' then
                    return true
                end
            end
        end
    end
    return false
end

function QBCore.Functions.GetPermission(source)
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    if license then
        if QBCore.Config.Server.PermissionList[license] then
            if QBCore.Config.Server.PermissionList[license].license == license then
                return QBCore.Config.Server.PermissionList[license].permission
            end
        end
    end
    return 'user'
end

-- Opt in or out of admin reports

function QBCore.Functions.IsOptin(source)
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    if QBCore.Functions.HasPermission(src, 'admin') then
        return QBCore.Config.Server.PermissionList[license].optin
    end
end

function QBCore.Functions.ToggleOptin(source)
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    if QBCore.Functions.HasPermission(src, 'admin') then
        QBCore.Config.Server.PermissionList[license].optin = not QBCore.Config.Server.PermissionList[license].optin
    end
end

-- Check if player is banned

function QBCore.Functions.IsPlayerBanned(source)
    local src = source
    local retval = false
    local message = ''
    local plicense = QBCore.Functions.GetIdentifier(src, 'license')
    local result = exports.oxmysql:executeSync('SELECT * FROM bans WHERE license = ?', { plicense })
    if result[1] then
        if os.time() < result[1].expire then
            retval = true
            local timeTable = os.date('*t', tonumber(result.expire))
            message = 'You have been banned from the server:\n' .. result[1].reason .. '\nYour ban expires ' .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
        else
            exports.oxmysql:execute('DELETE FROM bans WHERE id = ?', { result[1].id })
        end
    end
    return retval, message
end

-- Check for duplicate license

function QBCore.Functions.IsLicenseInUse(license)
    local players = GetPlayers()
    for _, player in pairs(players) do
        local identifiers = GetPlayerIdentifiers(player)
        for _, id in pairs(identifiers) do
            if string.find(id, 'license') then
                local playerLicense = id
                if playerLicense == license then
                    return true
                end
            end
        end
    end
    return false
end

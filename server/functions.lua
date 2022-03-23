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

--- Routingbucket stuff (Only touch if you know what you are doing)
_G.Player_Buckets = {} -- Bucket array containing all players that have been set to a different bucket
_G.Entity_Buckets = {} -- Bucket array containing all entities that have been set to a different bucket


--- Returns the objects related to buckets, first returned value is the player buckets , second one is entity buckets
function QBCore.Functions.GetBucketObjects()
    return _G.Player_Buckets, _G.Entity_Buckets
end


--- Will set the provided player id / source into the provided bucket id
function QBCore.Functions.SetPlayerBucket(player_source --[[int]],bucket --[[int]])
    if player_source and bucket then
        local plicense = QBCore.Functions.GetIdentifier(player_source, 'license')
        SetPlayerRoutingBucket(player_source, bucket)
        _G.Player_Buckets[plicense] = {player_id = player_source, player_bucket = bucket}
        return true
    else
        return false
    end
end

--- Will set any entity into the provided bucket, for example peds / vehicles / props / etc...
function QBCore.Functions.SetEntityBucket(entity --[[int]],bucket --[[int]])
    if entity and bucket then
        SetEntityRoutingBucket(entity, bucket)
        _G.Entity_Buckets[entity] = {entity_id = entity, entity_bucket = bucket}
        return true
    else
        return false
    end
end


-- Will return an array of all the player ids inside the current bucket
function QBCore.Functions.GetPlayersInBucket(bucket --[[int]])
    local curr_bucket_pool = {}
    if _G.Player_Buckets ~= nil then
        for k, v in pairs(_G.Player_Buckets) do
            if k['player_bucket'] == bucket then
                curr_bucket_pool[#curr_bucket_pool + 1] = k['player_id']
            end
        end
        return curr_bucket_pool
    else
        return false
    end
end


--- Will return an array of all the entities inside the current bucket (Not player entities , use GetPlayersInBucket for that)
function QBCore.Functions.GetEntitiesInBucket(bucket --[[int]])
    local curr_bucket_pool = {}
    if _G.Entity_Buckets ~= nil then
        for k, v in pairs(_G.Entity_Buckets) do
            if k['entity_bucket'] == bucket then
                curr_bucket_pool[#curr_bucket_pool + 1] = k['entity_id']
            end
        end
        return curr_bucket_pool
    else
        return false
    end
end

--- Will return true / false wheter the mentioned player id is present in the bucket provided
function QBCore.Functions.IsPlayerInBucket(player_source --[[int]] ,bucket --[[int]])
    local curr_player_bucket = GetPlayerRoutingBucket(player_source)
    return curr_player_bucket == bucket
end

-- Paychecks (standalone - don't touch)

function PaycheckLoop()
    local Players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(Players) do
        local payment = Player.PlayerData.job.payment
        if Player.PlayerData.job and payment > 0 and (QBShared.Jobs[Player.PlayerData.job.name].offDutyPay or Player.PlayerData.job.onduty) then
            if QBCore.Config.Money.PayCheckSociety then
                local account = exports['qb-bossmenu']:GetAccount(Player.PlayerData.job.name)
                if account ~= 0 then -- Checks if player is employed by a society
                    if account < payment then -- Checks if company has enough money to pay society
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('error.company_too_poor'), 'error')
                    else
                        Player.Functions.AddMoney('bank', payment)
                        TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name, payment)
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', {value = payment}))
                    end
                else
                    Player.Functions.AddMoney('bank', payment)
                    TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', {value = payment}))
                end
            else
                Player.Functions.AddMoney('bank', payment)
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', {value = payment}))
            end
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
        local result = MySQL.Sync.fetchSingle('SELECT * FROM whitelist WHERE license = ?', { plicense })
        if result then
            for _, id in pairs(identifiers) do
                if result.license == id then
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
        MySQL.Async.execute('DELETE FROM permissions WHERE license = ?', { plicense })

        MySQL.Async.insert('INSERT INTO permissions (name, license, permission) VALUES (?, ?, ?)', {
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
        MySQL.Async.execute('DELETE FROM permissions WHERE license = ?', { license })
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
    local result = MySQL.Sync.fetchSingle('SELECT * FROM bans WHERE license = ?', { plicense })
    if result then
        if os.time() < result.expire then
            retval = true
            local timeTable = os.date('*t', tonumber(result.expire))
            message = 'You have been banned from the server:\n' .. result[1].reason .. '\nYour ban expires ' .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
        else
            MySQL.Async.execute('DELETE FROM bans WHERE id = ?', { result[1].id })
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

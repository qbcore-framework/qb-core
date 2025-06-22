QBCore.Functions = {}
QBCore.Player_Buckets = {}
QBCore.Entity_Buckets = {}
QBCore.UsableItems = {}

-- Getters
-- Get your player first and then trigger a function on them
-- ex: local player = QBCore.Functions.GetPlayer(source)
-- ex: local example = player.Functions.functionname(parameter)
---Gets the coordinates of an entity
---@param entity number
---@return vector4
function QBCore.Functions.GetCoords(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return vector4(coords.x, coords.y, coords.z, heading)
end

---Gets player identifier of the given type
---@param source any
---@param idtype string
---@return string?
function QBCore.Functions.GetIdentifier(source, idtype)
    if GetConvarInt('sv_fxdkMode', 0) == 1 then return 'license:fxdk' end
    return GetPlayerIdentifierByType(source, idtype or 'license')
end

---Gets a players server id (source). Returns 0 if no player is found.
---@param identifier string
---@return number
function QBCore.Functions.GetSource(identifier)
    for src, _ in pairs(QBCore.Players) do
        local idens = GetPlayerIdentifiers(src)
        for _, id in pairs(idens) do
            if identifier == id then
                return src
            end
        end
    end
    return 0
end

---Get player with given server id (source)
---@param source any
---@return table
function QBCore.Functions.GetPlayer(source)
    if tonumber(source) ~= nil then -- If a number is a string ("1"), this will still correctly identify the index to use.
        return QBCore.Players[tonumber(source)]
    else
        return QBCore.Players[QBCore.Functions.GetSource(source)]
    end
end

---Get player by citizen id
---@param citizenid string
---@return table?
function QBCore.Functions.GetPlayerByCitizenId(citizenid)
    for src in pairs(QBCore.Players) do
        if QBCore.Players[src].PlayerData.citizenid == citizenid then
            return QBCore.Players[src]
        end
    end
    return nil
end

---Get offline player by citizen id
---@param citizenid string
---@return table?
function QBCore.Functions.GetOfflinePlayerByCitizenId(citizenid)
    return QBCore.Player.GetOfflinePlayer(citizenid)
end

---Get player by license
---@param license string
---@return table?
function QBCore.Functions.GetPlayerByLicense(license)
    return QBCore.Player.GetPlayerByLicense(license)
end

---Get player by phone number
---@param number number
---@return table?
function QBCore.Functions.GetPlayerByPhone(number)
    for src in pairs(QBCore.Players) do
        if QBCore.Players[src].PlayerData.charinfo.phone == number then
            return QBCore.Players[src]
        end
    end
    return nil
end

---Get player by account id
---@param account string
---@return table?
function QBCore.Functions.GetPlayerByAccount(account)
    for src in pairs(QBCore.Players) do
        if QBCore.Players[src].PlayerData.charinfo.account == account then
            return QBCore.Players[src]
        end
    end
    return nil
end

---Get player passing property and value to check exists
---@param property string
---@param value string
---@return table?
function QBCore.Functions.GetPlayerByCharInfo(property, value)
    for src in pairs(QBCore.Players) do
        local charinfo = QBCore.Players[src].PlayerData.charinfo
        if charinfo[property] ~= nil and charinfo[property] == value then
            return QBCore.Players[src]
        end
    end
    return nil
end

---Get all players. Returns the server ids of all players.
---@return table
function QBCore.Functions.GetPlayers()
    local sources = {}
    for k in pairs(QBCore.Players) do
        sources[#sources + 1] = k
    end
    return sources
end

---Will return an array of QB Player class instances
---unlike the GetPlayers() wrapper which only returns IDs
---@return table
function QBCore.Functions.GetQBPlayers()
    return QBCore.Players
end

--- Gets a list of all online players of a specified job or job type and the number
--- @param job string
--- @param checkOnDuty boolean If true, only players on duty will be returned
function QBCore.Functions.GetPlayersByJob(job, checkOnDuty)
    local players = {}
    local count = 0
    for src, Player in pairs(QBCore.Players) do
        local playerData = Player.PlayerData
        if playerData.job.name == job or playerData.job.type == job then
            if checkOnDuty then
                if playerData.job.onduty then
                    players[#players + 1] = src
                    count += 1
                end
            else
                players[#players + 1] = src
                count += 1
            end
        end
    end
    return players, count
end

---Gets a list of all on duty players of a specified job and the number
---@param job string
---@return table, number
function QBCore.Functions.GetPlayersOnDuty(job)
    local players, count = QBCore.Functions.GetPlayersByJob(job, true)
    return players, count
end

---Returns only the amount of players on duty for the specified job
---@param job string
---@return number
function QBCore.Functions.GetDutyCount(job)
    local _, count = QBCore.Functions.GetPlayersByJob(job, true)
    return count
end

--- @param source number source player's server ID.
--- @param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
--- @return string closestPlayer - The Player that is closest to the source player (or the provided coordinates). Returns -1 if no Players are found.
--- @return number closestDistance - The distance to the closest Player. Returns -1 if no Players are found.
function QBCore.Functions.GetClosestPlayer(source, coords)
    local ped = GetPlayerPed(source)
    local players = GetPlayers()
    local closestDistance, closestPlayer = -1, -1
    if coords then coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords end
    if not coords then coords = GetEntityCoords(ped) end
    for i = 1, #players do
        local playerId = players[i]
        local playerPed = GetPlayerPed(playerId)
        if playerPed ~= ped then
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - coords)
            if closestDistance == -1 or distance < closestDistance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

--- @param source number source player's server ID.
--- @param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
--- @return number closestObject - The Object that is closest to the source player (or the provided coordinates). Returns -1 if no Objects are found.
--- @return number closestDistance - The distance to the closest Object. Returns -1 if no Objects are found.
function QBCore.Functions.GetClosestObject(source, coords)
    local ped = GetPlayerPed(source)
    local objects = GetAllObjects()
    local closestDistance, closestObject = -1, -1
    if coords then coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords end
    if not coords then coords = GetEntityCoords(ped) end
    for i = 1, #objects do
        local objectCoords = GetEntityCoords(objects[i])
        local distance = #(objectCoords - coords)
        if closestDistance == -1 or closestDistance > distance then
            closestObject = objects[i]
            closestDistance = distance
        end
    end
    return closestObject, closestDistance
end

--- @param source number source player's server ID.
--- @param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
--- @return number closestVehicle - The Vehicle that is closest to the source player (or the provided coordinates). Returns -1 if no Vehicles are found.
--- @return number closestDistance - The distance to the closest Vehicle. Returns -1 if no Vehicles are found.
function QBCore.Functions.GetClosestVehicle(source, coords)
    local ped = GetPlayerPed(source)
    local vehicles = GetAllVehicles()
    local closestDistance, closestVehicle = -1, -1
    if coords then coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords end
    if not coords then coords = GetEntityCoords(ped) end
    for i = 1, #vehicles do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)
        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

--- @param source number source player's server ID.
--- @param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
--- @return number closestPed - The Ped that is closest to the source player (or the provided coordinates). Returns -1 if no Peds are found.
--- @return number closestDistance - The distance to the closest Ped. Returns -1 if no Peds are found.
function QBCore.Functions.GetClosestPed(source, coords)
    local ped = GetPlayerPed(source)
    local peds = GetAllPeds()
    local closestDistance, closestPed = -1, -1
    if coords then coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords end
    if not coords then coords = GetEntityCoords(ped) end
    for i = 1, #peds do
        if peds[i] ~= ped then
            local pedCoords = GetEntityCoords(peds[i])
            local distance = #(pedCoords - coords)
            if closestDistance == -1 or closestDistance > distance then
                closestPed = peds[i]
                closestDistance = distance
            end
        end
    end
    return closestPed, closestDistance
end

-- Routing buckets (Only touch if you know what you are doing)

---Returns the objects related to buckets, first returned value is the player buckets, second one is entity buckets
---@return table, table
function QBCore.Functions.GetBucketObjects()
    return QBCore.Player_Buckets, QBCore.Entity_Buckets
end

---Will set the provided player id / source into the provided bucket id
---@param source any
---@param bucket any
---@return boolean
function QBCore.Functions.SetPlayerBucket(source, bucket)
    if source and bucket then
        local plicense = QBCore.Functions.GetIdentifier(source, 'license')
        Player(source).state:set('instance', bucket, true)
        SetPlayerRoutingBucket(source, bucket)
        QBCore.Player_Buckets[plicense] = { id = source, bucket = bucket }
        return true
    else
        return false
    end
end

---Will set any entity into the provided bucket, for example peds / vehicles / props / etc.
---@param entity number
---@param bucket number
---@return boolean
function QBCore.Functions.SetEntityBucket(entity, bucket)
    if entity and bucket then
        SetEntityRoutingBucket(entity, bucket)
        QBCore.Entity_Buckets[entity] = { id = entity, bucket = bucket }
        return true
    else
        return false
    end
end

---Will return an array of all the player ids inside the current bucket
---@param bucket number
---@return table|boolean
function QBCore.Functions.GetPlayersInBucket(bucket)
    local curr_bucket_pool = {}
    if QBCore.Player_Buckets and next(QBCore.Player_Buckets) then
        for _, v in pairs(QBCore.Player_Buckets) do
            if v.bucket == bucket then
                curr_bucket_pool[#curr_bucket_pool + 1] = v.id
            end
        end
        return curr_bucket_pool
    else
        return false
    end
end

---Will return an array of all the entities inside the current bucket
---(not for player entities, use GetPlayersInBucket for that)
---@param bucket number
---@return table|boolean
function QBCore.Functions.GetEntitiesInBucket(bucket)
    local curr_bucket_pool = {}
    if QBCore.Entity_Buckets and next(QBCore.Entity_Buckets) then
        for _, v in pairs(QBCore.Entity_Buckets) do
            if v.bucket == bucket then
                curr_bucket_pool[#curr_bucket_pool + 1] = v.id
            end
        end
        return curr_bucket_pool
    else
        return false
    end
end

---Server side vehicle creation with optional callback
---the CreateVehicle RPC still uses the client for creation so players must be near
---@param source any
---@param model any
---@param coords vector
---@param warp boolean
---@return number
function QBCore.Functions.SpawnVehicle(source, model, coords, warp)
    local ped = GetPlayerPed(source)
    model = type(model) == 'string' and joaat(model) or model
    if not coords then coords = GetEntityCoords(ped) end
    local heading = coords.w and coords.w or 0.0
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true)
    while not DoesEntityExist(veh) do Wait(0) end
    if warp then
        while GetVehiclePedIsIn(ped) ~= veh do
            Wait(0)
            TaskWarpPedIntoVehicle(ped, veh, -1)
        end
    end
    while NetworkGetEntityOwner(veh) ~= source do Wait(0) end
    return veh
end

---Server side vehicle creation with optional callback
---the CreateAutomobile native is still experimental but doesn't use client for creation
---doesn't work for all vehicles!
---comment
---@param source any
---@param model any
---@param coords vector
---@param warp boolean
---@return number
function QBCore.Functions.CreateAutomobile(source, model, coords, warp)
    model = type(model) == 'string' and joaat(model) or model
    if not coords then coords = GetEntityCoords(GetPlayerPed(source)) end
    local heading = coords.w and coords.w or 0.0
    local CreateAutomobile = `CREATE_AUTOMOBILE`
    local veh = Citizen.InvokeNative(CreateAutomobile, model, coords, heading, true, true)
    while not DoesEntityExist(veh) do Wait(0) end
    if warp then TaskWarpPedIntoVehicle(GetPlayerPed(source), veh, -1) end
    return veh
end

--- New & more reliable server side native for creating vehicles
---comment
---@param source any
---@param model any
---@param vehtype any
-- The appropriate vehicle type for the model info.
-- Can be one of automobile, bike, boat, heli, plane, submarine, trailer, and (potentially), train.
-- This should be the same type as the type field in vehicles.meta.
---@param coords vector
---@param warp boolean
---@return number
function QBCore.Functions.CreateVehicle(source, model, vehtype, coords, warp)
    model = type(model) == 'string' and joaat(model) or model
    vehtype = type(vehtype) == 'string' and tostring(vehtype) or vehtype
    if not coords then coords = GetEntityCoords(GetPlayerPed(source)) end
    local heading = coords.w and coords.w or 0.0
    local veh = CreateVehicleServerSetter(model, vehtype, coords, heading)
    while not DoesEntityExist(veh) do Wait(0) end
    if warp then TaskWarpPedIntoVehicle(GetPlayerPed(source), veh, -1) end
    return veh
end

function PaycheckInterval()
    if not next(QBCore.Players) then
        SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckInterval) -- Prevent paychecks from stopping forever once 0 players
        return
    end
    for _, Player in pairs(QBCore.Players) do
        if not Player then return end
        local payment = QBShared.Jobs[Player.PlayerData.job.name]['grades'][tostring(Player.PlayerData.job.grade.level)].payment
        if not payment then payment = Player.PlayerData.job.payment end
        if Player.PlayerData.job and payment > 0 and (QBShared.Jobs[Player.PlayerData.job.name].offDutyPay or Player.PlayerData.job.onduty) then
            if QBCore.Config.Money.PayCheckSociety then
                local account = exports['qb-banking']:GetAccountBalance(Player.PlayerData.job.name)
                if account ~= 0 then
                    if account < payment then
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('error.company_too_poor'), 'error')
                    else
                        Player.Functions.AddMoney('bank', payment, 'paycheck')
                        exports['qb-banking']:RemoveMoney(Player.PlayerData.job.name, payment, 'Employee Paycheck')
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
                    end
                else
                    Player.Functions.AddMoney('bank', payment, 'paycheck')
                    TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
                end
            else
                Player.Functions.AddMoney('bank', payment, 'paycheck')
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
            end
        end
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckInterval)
end

-- Callback Functions --

---Trigger Client Callback
---@param name string
---@param source any
---@param cb function
---@param ... any
function QBCore.Functions.TriggerClientCallback(name, source, ...)
    local cb = nil
    local args = { ... }

    if QBCore.Shared.IsFunction(args[1]) then
        cb = args[1]
        table.remove(args, 1)
    end

    QBCore.ClientCallbacks[name] = {
        callback = cb,
        promise = promise.new()
    }

    TriggerClientEvent('QBCore:Client:TriggerClientCallback', source, name, table.unpack(args))

    if cb == nil then
        Citizen.Await(QBCore.ClientCallbacks[name].promise)
        return QBCore.ClientCallbacks[name].promise.value
    end
end

---Create Server Callback
---@param name string
---@param cb function
function QBCore.Functions.CreateCallback(name, cb)
    QBCore.ServerCallbacks[name] = cb
end

-- Items

---Create a usable item
---@param item string
---@param data function
function QBCore.Functions.CreateUseableItem(item, data)
    local rawFunc = nil

    if type(data) == 'table' then
        if rawget(data, '__cfx_functionReference') then
            rawFunc = data
        elseif data.cb and rawget(data.cb, '__cfx_functionReference') then
            rawFunc = data.cb
        elseif data.callback and rawget(data.callback, '__cfx_functionReference') then
            rawFunc = data.callback
        end
    elseif type(data) == 'function' then
        rawFunc = data
    end

    if rawFunc then
        QBCore.UsableItems[item] = {
            func = rawFunc,
            resource = GetInvokingResource()
        }
    end
end

---Checks if the given item is usable
---@param item string
---@return any
function QBCore.Functions.CanUseItem(item)
    return QBCore.UsableItems[item]
end

---Use item
---@param source any
---@param item string
function QBCore.Functions.UseItem(source, item)
    if GetResourceState('qb-inventory') == 'missing' then return end
    exports['qb-inventory']:UseItem(source, item)
end

---Kick Player
---@param source any
---@param reason string
---@param setKickReason boolean
---@param deferrals boolean
function QBCore.Functions.Kick(source, reason, setKickReason, deferrals)
    reason = '\n' .. reason .. '\n🔸 Check our Discord for further information: ' .. QBCore.Config.Server.Discord
    if setKickReason then
        setKickReason(reason)
    end
    CreateThread(function()
        if deferrals then
            deferrals.update(reason)
            Wait(2500)
        end
        if source then
            DropPlayer(source, reason)
        end
        for _ = 0, 4 do
            while true do
                if source then
                    if GetPlayerPing(source) >= 0 then
                        break
                    end
                    Wait(100)
                    CreateThread(function()
                        DropPlayer(source, reason)
                    end)
                end
            end
            Wait(5000)
        end
    end)
end

---Check if player is whitelisted, kept like this for backwards compatibility or future plans
---@param source any
---@return boolean
function QBCore.Functions.IsWhitelisted(source)
    if not QBCore.Config.Server.Whitelist then return true end
    if QBCore.Functions.HasPermission(source, QBCore.Config.Server.WhitelistPermission) then return true end
    return false
end

-- Setting & Removing Permissions

---Add permission for player
---@param source any
---@param permission string
function QBCore.Functions.AddPermission(source, permission)
    if not IsPlayerAceAllowed(source, permission) then
        ExecuteCommand(('add_principal player.%s qbcore.%s'):format(source, permission))
        QBCore.Commands.Refresh(source)
    end
end

---Remove permission from player
---@param source any
---@param permission string
function QBCore.Functions.RemovePermission(source, permission)
    if permission then
        if IsPlayerAceAllowed(source, permission) then
            ExecuteCommand(('remove_principal player.%s qbcore.%s'):format(source, permission))
            QBCore.Commands.Refresh(source)
        end
    else
        for _, v in pairs(QBCore.Config.Server.Permissions) do
            if IsPlayerAceAllowed(source, v) then
                ExecuteCommand(('remove_principal player.%s qbcore.%s'):format(source, v))
                QBCore.Commands.Refresh(source)
            end
        end
    end
end

-- Checking for Permission Level

---Check if player has permission
---@param source any
---@param permission string
---@return boolean
function QBCore.Functions.HasPermission(source, permission)
    if type(permission) == 'string' then
        if IsPlayerAceAllowed(source, permission) then return true end
    elseif type(permission) == 'table' then
        for _, permLevel in pairs(permission) do
            if IsPlayerAceAllowed(source, permLevel) then return true end
        end
    end

    return false
end

---Get the players permissions
---@param source any
---@return table
function QBCore.Functions.GetPermission(source)
    local src = source
    local perms = {}
    for _, v in pairs(QBCore.Config.Server.Permissions) do
        if IsPlayerAceAllowed(src, v) then
            perms[v] = true
        end
    end
    return perms
end

---Get admin messages opt-in state for player
---@param source any
---@return boolean
function QBCore.Functions.IsOptin(source)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    if not license or not QBCore.Functions.HasPermission(source, 'admin') then return false end
    local Player = QBCore.Functions.GetPlayer(source)
    return Player.PlayerData.optin
end

---Toggle opt-in to admin messages
---@param source any
function QBCore.Functions.ToggleOptin(source)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    if not license or not QBCore.Functions.HasPermission(source, 'admin') then return end
    local Player = QBCore.Functions.GetPlayer(source)
    Player.PlayerData.optin = not Player.PlayerData.optin
    Player.Functions.SetPlayerData('optin', Player.PlayerData.optin)
end

---Check if player is banned
---@param source any
---@return boolean, string?
function QBCore.Functions.IsPlayerBanned(source)
    local plicense = QBCore.Functions.GetIdentifier(source, 'license')
    local result = MySQL.single.await('SELECT id, reason, expire FROM bans WHERE license = ?', { plicense })
    if not result then return false end
    if os.time() < result.expire then
        local timeTable = os.date('*t', tonumber(result.expire))
        return true, 'You have been banned from the server:\n' .. result.reason .. '\nYour ban expires ' .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
    else
        MySQL.query('DELETE FROM bans WHERE id = ?', { result.id })
    end
    return false
end

-- Retrieves information about the database connection.
--- @return table; A table containing the database information.
function QBCore.Functions.GetDatabaseInfo()
    local details = {
        exists = false,
        database = '',
    }
    local connectionString = GetConvar('mysql_connection_string', '')

    if connectionString == '' then
        return details
    elseif connectionString:find('mysql://') then
        connectionString = connectionString:sub(9, -1)
        details.database = connectionString:sub(connectionString:find('/') + 1, -1):gsub('[%?]+[%w%p]*$', '')
        details.exists = true
        return details
    else
        connectionString = { string.strsplit(';', connectionString) }

        for i = 1, #connectionString do
            local v = connectionString[i]
            if v:match('database') then
                details.database = v:sub(10, #v)
                details.exists = true
                return details
            end
        end
    end
end

---Check for duplicate license
---@param license any
---@return boolean
function QBCore.Functions.IsLicenseInUse(license)
    local players = GetPlayers()
    for _, player in pairs(players) do
        local playerLicense = QBCore.Functions.GetIdentifier(player, 'license')
        if playerLicense == license then return true end
    end
    return false
end

-- Utility functions

---Check if a player has an item [deprecated]
---@param source any
---@param items table|string
---@param amount number
---@return boolean
function QBCore.Functions.HasItem(source, items, amount)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:HasItem(source, items, amount)
end

---Notify
---@param source any
---@param text string
---@param type string
---@param length number
function QBCore.Functions.Notify(source, text, type, length)
    TriggerClientEvent('QBCore:Notify', source, text, type, length)
end

---???? ... ok
---@param source any
---@param data any
---@param pattern any
---@return boolean
function QBCore.Functions.PrepForSQL(source, data, pattern)
    data = tostring(data)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local result = string.match(data, pattern)
    if not result or string.len(result) ~= string.len(data) then
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'SQL Exploit Attempted', 'red', string.format('%s attempted to exploit SQL!', player.PlayerData.license))
        return false
    end
    return true
end

for functionName, func in pairs(QBCore.Functions) do
    if type(func) == 'function' then
        exports(functionName, func)
    end
end
-- Access a specific function directly:
-- exports['qb-core']:Notify(source, 'Hello Player!')

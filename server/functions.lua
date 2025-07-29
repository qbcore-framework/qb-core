-- Getters
-- Get your player first and then trigger a function on them
-- ex: local player = QBCore.Functions.GetPlayer(source)
-- ex: local example = player.Functions.functionname(parameter)

---Gets the coordinates of an entity
---@param entity number
---@return vector4
---@diagnostic disable-next-line: duplicate-set-field
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
function QBCore.Functions.GetOfflinePlayer(citizenid)
    if not citizenid then return nil end
    local row = MySQL.prepare.await('SELECT * FROM players WHERE citizenid = ?', { citizenid })
    if not row then return nil end
    row.money    = json.decode(row.money) or {}
    row.job      = json.decode(row.job) or {}
    row.gang     = json.decode(row.gang) or {}
    row.position = json.decode(row.position) or {}
    row.metadata = json.decode(row.metadata) or {}
    row.charinfo = json.decode(row.charinfo) or {}
    return QBCore.Player.CheckPlayerData(nil, row)
end

---Get player by license
---@param license string
---@return table?
function QBCore.Functions.GetPlayerByLicense(license)
    if license then
        local source = QBCore.Functions.GetSource(license)
        if source > 0 then
            return QBCore.Players[source]
        else
            return QBCore.Player.GetOfflinePlayerByLicense(license)
        end
    end
    return nil
end

---Get offline player by license
---@param license string
---@return table?
function QBCore.Functions.GetOfflinePlayerByLicense(license)
    if license then
        local PlayerData = MySQL.prepare.await('SELECT * FROM players where license = ?', { license })
        if PlayerData then
            PlayerData.money = json.decode(PlayerData.money)
            PlayerData.job = json.decode(PlayerData.job)
            PlayerData.gang = json.decode(PlayerData.gang)
            PlayerData.position = json.decode(PlayerData.position)
            PlayerData.metadata = json.decode(PlayerData.metadata)
            PlayerData.charinfo = json.decode(PlayerData.charinfo)
            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
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
---@diagnostic disable-next-line: duplicate-set-field
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

---Gets a list of all on duty players of a specified job and the number
---@param job string
---@return table, number
function QBCore.Functions.GetPlayersOnDuty(job)
    local players = {}
    local count = 0
    for src, Player in pairs(QBCore.Players) do
        if Player.PlayerData.job.name == job then
            if Player.PlayerData.job.onduty then
                players[#players + 1] = src
                count += 1
            end
        end
    end
    return players, count
end

---Returns only the amount of players on duty for the specified job
---@param job string
---@return number
function QBCore.Functions.GetDutyCount(job)
    local count = 0
    for _, Player in pairs(QBCore.Players) do
        if Player.PlayerData.job.name == job then
            if Player.PlayerData.job.onduty then
                count += 1
            end
        end
    end
    return count
end

---@param source number source player's server ID.
---@param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
---@return string closestPlayer - The Player that is closest to the source player (or the provided coordinates). Returns -1 if no Players are found.
---@return number closestDistance - The distance to the closest Player. Returns -1 if no Players are found.
---@diagnostic disable-next-line: duplicate-set-field
function QBCore.Functions.GetClosestPlayer(source, coords)
    local ped = GetPlayerPed(source)
    local players = GetPlayers()
    local closestDistance, closestPlayer = -1, "-1"
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

---@param source number source player's server ID.
---@param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
---@return number closestObject - The Object that is closest to the source player (or the provided coordinates). Returns -1 if no Objects are found.
---@return number closestDistance - The distance to the closest Object. Returns -1 if no Objects are found.
---@diagnostic disable-next-line: duplicate-set-field
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

---@param source number source player's server ID.
---@param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
---@return number closestVehicle - The Vehicle that is closest to the source player (or the provided coordinates). Returns -1 if no Vehicles are found.
---@return number closestDistance - The distance to the closest Vehicle. Returns -1 if no Vehicles are found.
---@diagnostic disable-next-line: duplicate-set-field
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

---@param source number source player's server ID.
---@param coords vector The coordinates to calculate the distance from. Can be a table with x, y, z fields or a vector3. If not provided, the source player's Ped's coordinates are used.
---@return number closestPed - The Ped that is closest to the source player (or the provided coordinates). Returns -1 if no Peds are found.
---@return number closestDistance - The distance to the closest Ped. Returns -1 if no Peds are found.
---@diagnostic disable-next-line: duplicate-set-field
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

        if plicense then
            Player(source).state:set('instance', bucket, true)
            SetPlayerRoutingBucket(source, bucket)
            QBCore.Player_Buckets[plicense] = { id = source, bucket = bucket }
            return true
        end
    end

    return false
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
---@diagnostic disable-next-line: duplicate-set-field
function QBCore.Functions.SpawnVehicle(source, model, coords, warp)
    local ped = GetPlayerPed(source)
    model = type(model) == 'string' and joaat(model) or model
    if not coords then coords = GetEntityCoords(ped) end
    local heading = coords.w and coords.w or 0.0
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true)
    while not DoesEntityExist(veh) do Wait(0) end
    if warp then
        while GetVehiclePedIsIn(ped, false) ~= veh do
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
    local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")
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
    local veh = CreateVehicleServerSetter(model, vehtype, coords.x, coords.y, coords.z, heading)
    while not DoesEntityExist(veh) do Wait(0) end
    if warp then TaskWarpPedIntoVehicle(GetPlayerPed(source), veh, -1) end
    return veh
end

-- Callback Functions --

---Trigger Client Callback
---@param name string
---@param source any
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

---Kick Player
---@param source any
---@param reason string
---@param setKickReason? function
---@param deferrals any
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
---@return table | nil; A table containing the database information.
function QBCore.Functions.GetDatabaseInfo()
    local connectionString = GetConvar('mysql_connection_string', '')
    local details = {
        exists = false,
        database = '',
    }

    if connectionString == '' then
        return details
    elseif connectionString:find('mysql://') then
        connectionString = connectionString:sub(9, -1)
        details.database = connectionString:sub(connectionString:find('/') + 1, -1):gsub('[%?]+[%w%p]*$', '')
        details.exists = true
        return details
    else
        local data = { string.strsplit(';', connectionString) }

        for i = 1, #data do
            local v = data[i]
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

---Notify
---@param source any
---@param text string
---@param type string
---@param length number
---@diagnostic disable-next-line: duplicate-set-field
function QBCore.Functions.Notify(source, text, type, length)
    TriggerClientEvent('QBCore:Notify', source, text, type, length)
end

---Creates a citizen id
---@return string
function QBCore.Functions.CreateCitizenId()
    local CitizenId = tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(5)):upper()
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE citizenid = ?) AS uniqueCheck', { CitizenId })
    if result == 0 then return CitizenId end
    return QBCore.Functions.CreateCitizenId()
end

---Creates a unique account number
---@return string
function QBCore.Functions.CreateAccountNumber()
    local AccountNumber = 'US0' .. math.random(1, 9) .. 'QBCore' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.account")) = ?) AS uniqueCheck', { AccountNumber })
    if result == 0 then return AccountNumber end
    return QBCore.Functions.CreateAccountNumber()
end

---Creates a unique phone number
---@return string
function QBCore.Functions.CreatePhoneNumber()
    local PhoneNumber = math.random(100, 999) .. math.random(1000000, 9999999)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.phone")) = ?) AS uniqueCheck', { PhoneNumber })
    if result == 0 then return PhoneNumber end
    return QBCore.Functions.CreatePhoneNumber()
end

---Creates a unique fingerprint id
---@return string
function QBCore.Functions.CreateFingerId()
    local FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.fingerprint")) = ?) AS uniqueCheck', { FingerId })
    if result == 0 then return FingerId end
    return QBCore.Functions.CreateFingerId()
end

---Creates a unique wallet id
---@return string
function QBCore.Functions.CreateWalletId()
    local WalletId = 'QB-' .. math.random(11111111, 99999999)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.walletid")) = ?) AS uniqueCheck', { WalletId })
    if result == 0 then return WalletId end
    return QBCore.Functions.CreateWalletId()
end

---Creates a unique serial number for the phone
---@return number
function QBCore.Functions.CreateSerialNumber()
    local SerialNumber = math.random(11111111, 99999999)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.phonedata.SerialNumber")) = ?) AS uniqueCheck', { SerialNumber })
    if result == 0 then return SerialNumber end
    return QBCore.Functions.CreateSerialNumber()
end

-- Add a new function to the Functions table of the player class
-- Use-case:
--[[
    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
        QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "functionName", function(oneArg, orMore)
            -- do something here
        end)
    end)
]]

---Adding new function to the player class
---@param ids number|table
---@param methodName string
---@param handler function
function QBCore.Functions.AddPlayerMethod(ids, methodName, handler)
    local idType = type(ids)
    if idType == 'number' then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddMethod(methodName, handler)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddMethod(methodName, handler)
        end
    elseif idType == 'table' and table.type(ids) == 'array' then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerMethod(ids[i], methodName, handler)
        end
    end
end

-- Add a new field table of the player class
-- Use-case:
--[[
    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
        QBCore.Functions.AddPlayerField(Player.PlayerData.source, "fieldName", "fieldData")
    end)
]]

---Adding new field to the player class
---@param ids number|table
---@param fieldName string
---@param data any
function QBCore.Functions.AddPlayerField(ids, fieldName, data)
    local idType = type(ids)
    if idType == 'number' then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddField(fieldName, data)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddField(fieldName, data)
        end
    elseif idType == 'table' and table.type(ids) == 'array' then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerField(ids[i], fieldName, data)
        end
    end
end

for functionName, func in pairs(QBCore.Functions) do
    if type(func) == 'function' then
        exports(functionName, func)
    end
end

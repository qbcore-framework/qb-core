function QBCore.Functions.GetVehicles()
    if IsDuplicityVersion() then
        return GetAllVehicles()
    else
        return GetGamePool('CVehicle')
    end
end

function QBCore.Functions.GetObjects()
    if IsDuplicityVersion() then
        return GetAllObjects()
    else
        return GetGamePool('CObject')
    end
end

function QBCore.Functions.GetPeds()
    if IsDuplicityVersion() then
        local pedPool = GetAllPeds()
        local peds = {}

        for i = 1, #pedPool do
            if NetworkGetEntityOwner(pedPool[i]) == 0 then
                table.insert(peds, pedPool[i])
            end
        end

        return peds
    else
        local pedPool = GetGamePool('CPed')
        local peds = {}

        for i = 1, #pedPool do
            if not IsPedAPlayer(pedPool[i]) then
                table.insert(peds, pedPool[i])
            end
        end

        return peds
    end
end

function QBCore.Functions.GetPlayers()
    if IsDuplicityVersion() then
        local sources = {}
        for k in pairs(QBCore.Players) do
            sources[#sources + 1] = k
        end
        return sources
    else
        return GetActivePlayers()
    end
end

function QBCore.Functions.GetCoords(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return vector4(coords.x, coords.y, coords.z, heading)
end

function QBCore.Functions.HasItem(...)
    if GetResourceState('qb-inventory') == 'missing' then return false end
    if IsDuplicityVersion() then
        local source, items, amount = ...
        return exports['qb-inventory']:HasItem(source, items, amount)
    else
        local items, amount = ...
        return exports['qb-inventory']:HasItem(items, amount)
    end
end

function QBCore.Functions.Notify(...)
    if IsDuplicityVersion() then
        local source, text, texttype, length = ...
        TriggerClientEvent('QBCore:Notify', source, text, texttype, length)
    else
        local text, texttype, length, icon = ...
        local message = {
            action = 'notify',
            type = texttype or 'primary',
            length = length or 5000,
        }
        if type(text) == 'table' then
            message.text = text.text or 'Placeholder'
            message.caption = text.caption or 'Placeholder'
        else
            message.text = text
        end
        if icon then
            message.icon = icon
        end
        SendNUIMessage(message)
    end
end

function QBCore.Functions.SpawnVehicle(...)
    if IsDuplicityVersion() then
        local source, model, coords, warp = ...
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
    else
        local model, cb, coords, isnetworked, teleportInto = ...
        local ped = PlayerPedId()
        model = type(model) == 'string' and joaat(model) or model
        if not IsModelInCdimage(model) then return end
        if coords then
            coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end
        isnetworked = isnetworked == nil or isnetworked
        QBCore.Functions.LoadModel(model)
        local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w or 0.0, isnetworked, false)
        local netid = NetworkGetNetworkIdFromEntity(veh)
        SetVehicleHasBeenOwnedByPlayer(veh, true)
        SetNetworkIdCanMigrate(netid, true)
        SetVehicleNeedsToBeHotwired(veh, false)
        SetVehRadioStation(veh, 'OFF')
        SetVehicleFuelLevel(veh, 100.0)
        SetModelAsNoLongerNeeded(model)
        if teleportInto then TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1) end
        if cb then cb(veh) end
    end
end

function QBCore.Functions.GetClosestPed(...)
    if IsDuplicityVersion() then
        local source, coords = ...
        local ped = GetPlayerPed(source)
        local peds = GetAllPeds()
        local closestDistance, closestPed = -1, -1

        if coords then
            coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

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
    else
        local coords, ignoreList = ...
        local ped = PlayerPedId()
        if coords then
            coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

        ignoreList = ignoreList or {}
        local peds = QBCore.Functions.GetPeds(ignoreList)
        local closestDistance, closestPed = -1, -1

        for i = 1, #peds do
            local pedCoords = GetEntityCoords(peds[i])
            local distance = #(pedCoords - coords)
            if closestDistance == -1 or closestDistance > distance then
                closestPed = peds[i]
                closestDistance = distance
            end
        end
        return closestPed, closestDistance
    end
end

function QBCore.Functions.GetClosestVehicle(...)
    if IsDuplicityVersion() then
        local source, coords = ...
        local ped = GetPlayerPed(source)
        local vehicles = GetAllVehicles()
        local closestDistance, closestVehicle = -1, -1

        if coords then
            coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

        for i = 1, #vehicles do
            local vehicleCoords = GetEntityCoords(vehicles[i])
            local distance = #(vehicleCoords - coords)
            if closestDistance == -1 or closestDistance > distance then
                closestVehicle = vehicles[i]
                closestDistance = distance
            end
        end
        return closestVehicle, closestDistance
    else
        local coords = ...
        local ped = PlayerPedId()
        local vehicles = GetGamePool('CVehicle')
        local closestDistance, closestVehicle = -1, -1

        if coords then
            coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

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
end

function QBCore.Functions.GetClosestObject(...)
    if IsDuplicityVersion() then
        local source, coords = ...
        local ped = GetPlayerPed(source)
        local objects = GetAllObjects()
        local closestDistance, closestObject = -1, -1

        if coords then
            coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

        for i = 1, #objects do
            local objectCoords = GetEntityCoords(objects[i])
            local distance = #(objectCoords - coords)
            if closestDistance == -1 or closestDistance > distance then
                closestObject = objects[i]
                closestDistance = distance
            end
        end
        return closestObject, closestDistance
    else
        local coords = ...
        local ped = PlayerPedId()
        local objects = GetGamePool('CObject')
        local closestDistance, closestObject = -1, -1

        if coords then
            coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

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
end

function QBCore.Functions.GetClosestPlayer(...)
    if IsDuplicityVersion() then
        local source, coords = ...
        local ped = GetPlayerPed(source)
        local players = GetPlayers()
        local closestDistance, closestPlayer = -1, -1

        if coords then
            coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

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
    else
        local coords = ...
        local ped = PlayerPedId()

        if coords then
            coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
        else
            coords = GetEntityCoords(ped)
        end

        local closestPlayers = QBCore.Functions.GetPlayersFromCoords(coords)
        local closestDistance, closestPlayer = -1, -1

        for i = 1, #closestPlayers do
            if closestPlayers[i] ~= PlayerId() and closestPlayers[i] ~= -1 then
                local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
                local distance = #(pos - coords)
                if closestDistance == -1 or closestDistance > distance then
                    closestPlayer = closestPlayers[i]
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance
    end
end

local StringCharset = {}
local NumberCharset = {}

for i = 48, 57 do NumberCharset[#NumberCharset + 1] = string.char(i) end
for i = 65, 90 do StringCharset[#StringCharset + 1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset + 1] = string.char(i) end

-- String Functions

function QBCore.Functions.RandomStr(length)
    local result = ''
    for i = 1, length do
        result = result .. StringCharset[math.random(1, #StringCharset)]
    end
    return result
end

function QBCore.Functions.SplitStr(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
        result[#result + 1] = string.sub(str, from, delim_from - 1)
        from = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end
    result[#result + 1] = string.sub(str, from)
    return result
end

function QBCore.Functions.Trim(value)
    if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

function QBCore.Functions.FirstToUpper(value)
    if not value then return nil end
    return (value:gsub('^%l', string.upper))
end

function QBCore.Functions.SplitLines(str)
    local lines = {}
    for line in str:gmatch('[^\r\n]+') do
        table.insert(lines, line)
    end
    return lines
end

function QBCore.Functions.NormalizeString(str)
    return str:gsub('[^%w]', ''):lower()
end

-- Number Functions

function QBCore.Functions.RandomInt(length)
    local result = ''
    for i = 1, length do
        result = result .. NumberCharset[math.random(1, #NumberCharset)]
    end
    return result
end

function QBCore.Functions.Round(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end

function QBCore.Functions.Clamp(value, min, max)
    return math.max(min, math.min(value, max))
end

-- Table Functions

function QBCore.Functions.TableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

function QBCore.Functions.ShuffleTable(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(1, i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

function QBCore.Functions.DeepCopy(tbl)
    if type(tbl) ~= 'table' then return tbl end
    local copy = {}
    for k, v in pairs(tbl) do
        copy[k] = QBCore.Functions.DeepCopy(v)
    end
    return copy
end

function QBCore.Functions.ContainsKey(tbl, key)
    return tbl[key] ~= nil
end

function QBCore.Functions.Contains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then return true end
    end
    return false
end

function QBCore.Functions.MergeTables(tbl1, tbl2)
    local merged = QBCore.Functions.DeepCopy(tbl1)
    for k, v in pairs(tbl2) do
        merged[k] = v
    end
    return merged
end

function QBCore.Functions.ReverseTable(tbl)
    local reversed = {}
    for i = #tbl, 1, -1 do
        table.insert(reversed, tbl[i])
    end
    return reversed
end

function QBCore.Functions.RandomWeightedChoice(choices)
    local totalWeight = 0
    for _, choice in pairs(choices) do
        totalWeight = totalWeight + choice.weight
    end

    local rand = math.random() * totalWeight
    local cumulative = 0

    for key, choice in pairs(choices) do
        cumulative = cumulative + choice.weight
        if rand <= cumulative then return key, choice end
    end
end

function QBCore.Functions.GetRandomElement(tbl)
    return tbl[math.random(1, #tbl)]
end

function QBCore.Functions.PrintTable(tbl, indent)
    indent = indent or 0
    if type(tbl) == 'table' then
        for k, v in pairs(tbl) do
            local tblType = type(v)
            local formatting = ('%s ^3%s:^0'):format(string.rep('  ', indent), k)
            if tblType == 'table' then
                print(formatting)
                QBCore.Functions.PrintTable(v, indent + 1)
            elseif tblType == 'boolean' then
                print(('%s^1 %s ^0'):format(formatting, tostring(v)))
            elseif tblType == 'function' then
                print(('%s^9 %s ^0'):format(formatting, tostring(v)))
            elseif tblType == 'number' then
                print(('%s^5 %s ^0'):format(formatting, v))
            elseif tblType == 'string' then
                print(("%s ^2'%s' ^0"):format(formatting, v))
            else
                print(('%s^2 %s ^0'):format(formatting, tostring(v)))
            end
        end
    else
        print(('%s^0 %s'):format(string.rep('  ', indent), tostring(tbl)))
    end
end

function QBCore.Functions.Debug(tbl, indent, resource)
    local resource_name = resource or GetInvokingResource() or 'qb-core'
    print(('\x1b[4m\x1b[36m[ %s : DEBUG]\x1b[0m'):format(resource_name))
    QBCore.Functions.PrintTable(tbl, indent)
    print('\x1b[4m\x1b[36m[ END DEBUG ]\x1b[0m')
end

function QBCore.Functions.ShowError(resource, msg)
    local resource_name = resource or GetInvokingResource() or 'qb-core'
    print('\x1b[31m[' .. resource_name .. ':ERROR]\x1b[0m ' .. msg)
end

function QBCore.Functions.ShowSuccess(resource, msg)
    local resource_name = resource or GetInvokingResource() or 'qb-core'
    print('\x1b[32m[' .. resource_name .. ':LOG]\x1b[0m ' .. msg)
end

function QBCore.Functions.IsFunction(value)
    if type(value) == 'table' then
        return value.__cfx_functionReference ~= nil and type(value.__cfx_functionReference) == 'string'
    end
    return type(value) == 'function'
end

QBCore.Functions = {}

-- Player

function QBCore.Functions.GetPlayerData(cb)
    if not cb then return QBCore.PlayerData end
    cb(QBCore.PlayerData)
end

function QBCore.Functions.GetCoords(entity)
    return vector4(GetEntityCoords(entity), GetEntityHeading(entity))
end

function QBCore.Functions.HasItem(item)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        p:resolve(result)
    end, item)
    return Citizen.Await(p)
end

-- Utility

function QBCore.Functions.DrawText(x, y, width, height, scale, r, g, b, a, text)
    -- Use local function instead
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function QBCore.Functions.DrawText3D(x, y, z, text)
    -- Use local function instead
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function QBCore.Functions.CreateBlip(coords, sprite, display, scale, colour, shortRange, title, alpha, friendly, bright, category, hiddenOnLegend, highDetail, rotation, cone, shrink, showHeight, showNumber, showOutline)
    if not coords or (type(coords) ~= 'table' and type(coords) ~= 'vector3') then
        print("Blip failed to create, the coords were not specified or was specified in the wrong format, coords must be a table or vector3, debug log: ")
        print(("Coords: %s Sprite: %s Display: %s scale: %s shortRange: %s Title: %s Alpha: %s Friendly: %s Bright: %s Category: %s Hidden On Legend: %s High Detail: %s Rotation: %s Cone: %s Shrink: %s Show Heigt: %s Show Number: %s Show Outline: %s"):format(coords, sprite, display, scale, colour, shortRange, title, alpha, friendly, bright, category, hiddenOnLegend, highDetail, rotation, cone, shrink, showHeight, showNumber, showOutline))
        return
    end
    coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    local blip = AddBlipForCoord(coords)
    if sprite then SetBlipSprite(blip, sprite) end
    if display then SetBlipDisplay(blip, display) end
    if scale then SetBlipScale(blip, scale) end
    if colour then SetBlipColour(blip, colour) end
    if shortRange ~= nil then SetBlipAsShortRange(blip, shortRange) end
    if title then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(title)
        EndTextCommandSetBlipName(blip)
    end
    if alpha then SetBlipAlpha(blip, alpha) end
    if friendly ~= nil then SetBlipAsFriendly(blip, friendly) end
    if bright ~= nil then SetBlipBright(blip, bright) end
    if category then SetBlipCategory(blip, category) end -- categories can be found here: https://docs.fivem.net/natives/?_0x234CDD44D996FD9A
    if hiddenOnLegend ~= nil then SetBlipHiddenOnLegend(blip, hiddenOnLegend) end
    if highDetail ~= nil then SetBlipHighDetail(blip, highDetail) end
    if rotation then SetBlipRotation(blip, rotation) end -- Required to be an integer
    if cone ~= nil then SetBlipShowCone(blip, cone) end
    if shrink ~= nil then SetBlipShrink(blip, shrink) end
    if showHeight ~= nil then ShowHeightOnBlip(blip, showHeight) end
    if showNumber then ShowNumberOnBlip(blip, showNumber) end
    if showOutline ~= nil then ShowOutlineIndicatorOnBlip(blip, showOutline) end
    return blip
end

function QBCore.Functions.RequestAnimDict(animDict)
	if HasAnimDictLoaded(animDict) then return end
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(0)
	end
end

function QBCore.Functions.PlayAnim(animDict, animName, upperbodyOnly, duration)
    local flags = upperbodyOnly == true and 16 or 0
    local runTime = duration ~= nil and duration or -1
    QBCore.Functions.RequestAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 1.0, runTime, flags, 0.0, false, false, true)
    RemoveAnimDict(animDict)
end

function QBCore.Functions.LoadModel(model)
    if HasModelLoaded(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

RegisterNUICallback('getNotifyConfig', function(_, cb)
    cb(QBCore.Config.Notify)
end)

function QBCore.Functions.Notify(text, texttype, length)
    if type(text) == "table" then
        local ttext = text.text or 'Placeholder'
        local caption = text.caption or 'Placeholder'
        texttype = texttype or 'primary'
        length = length or 5000
        SendNUIMessage({
            action = 'notify',
            type = texttype,
            length = length,
            text = ttext,
            caption = caption
        })
    else
        texttype = texttype or 'primary'
        length = length or 5000
        SendNUIMessage({
            action = 'notify',
            type = texttype,
            length = length,
            text = text
        })
    end
end

function QBCore.Debug(resource, obj, depth)
    TriggerServerEvent('QBCore:DebugSomething', resource, obj, depth)
end

function QBCore.Functions.TriggerCallback(name, cb, ...)
    QBCore.ServerCallbacks[name] = cb
    TriggerServerEvent('QBCore:Server:TriggerCallback', name, ...)
end

function QBCore.Functions.Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    if GetResourceState('progressbar') ~= 'started' then error('progressbar needs to be started in order for QBCore.Functions.Progressbar to work') end
    exports['progressbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish then
                onFinish()
            end
        else
            if onCancel then
                onCancel()
            end
        end
    end)
end

-- Getters

function QBCore.Functions.GetVehicles()
    return GetGamePool('CVehicle')
end

function QBCore.Functions.GetObjects()
    return GetGamePool('CObject')
end

function QBCore.Functions.GetPlayers()
    return GetActivePlayers()
end

function QBCore.Functions.GetPeds(ignoreList)
    local pedPool = GetGamePool('CPed')
    local peds = {}
    ignoreList = ignoreList or {}
    for i = 1, #pedPool, 1 do
        local found = false
        for j = 1, #ignoreList, 1 do
            if ignoreList[j] == pedPool[i] then
                found = true
            end
        end
        if not found then
            peds[#peds + 1] = pedPool[i]
        end
    end
    return peds
end

function QBCore.Functions.GetClosestPed(coords, ignoreList)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local ignoreList = ignoreList or {}
    local peds = QBCore.Functions.GetPeds(ignoreList)
    local closestDistance = -1
    local closestPed = -1
    for i = 1, #peds, 1 do
        local pedCoords = GetEntityCoords(peds[i])
        local distance = #(pedCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestPed = peds[i]
            closestDistance = distance
        end
    end
    return closestPed, closestDistance
end

function QBCore.Functions.IsWearingGloves()
    local ped = PlayerPedId()
    local armIndex = GetPedDrawableVariation(ped, 3)
    local model = GetEntityModel(ped)
    if model == `mp_m_freemode_01` then
        if QBCore.Shared.MaleNoGloves[armIndex] then
            return false
        end
    else
        if QBCore.Shared.FemaleNoGloves[armIndex] then
            return false
        end
    end
    return true
end

function QBCore.Functions.GetClosestPlayer(coords)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords(coords)
    local closestDistance = -1
    local closestPlayer = -1
    for i = 1, #closestPlayers, 1 do
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

function QBCore.Functions.GetPlayersFromCoords(coords, distance)
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    distance = distance or 5
    local closePlayers = {}
    for _, player in pairs(players) do
        local target = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(target)
        local targetdistance = #(targetCoords - coords)
        if targetdistance <= distance then
            closePlayers[#closePlayers + 1] = player
        end
    end
    return closePlayers
end

function QBCore.Functions.GetClosestVehicle(coords)
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

function QBCore.Functions.GetClosestObject(coords)
    local ped = PlayerPedId()
    local objects = GetGamePool('CObject')
    local closestDistance = -1
    local closestObject = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #objects, 1 do
        local objectCoords = GetEntityCoords(objects[i])
        local distance = #(objectCoords - coords)
        if closestDistance == -1 or closestDistance > distance then
            closestObject = objects[i]
            closestDistance = distance
        end
    end
    return closestObject, closestDistance
end

function QBCore.Functions.GetClosestBone(entity, list)
    local playerCoords, bone, coords, distance = GetEntityCoords(PlayerPedId())
    for _, element in pairs(list) do
        local boneCoords = GetWorldPositionOfEntityBone(entity, element.id or element)
        local boneDistance = #(playerCoords - boneCoords)
        if not coords then
            bone, coords, distance = element, boneCoords, boneDistance
        elseif distance > boneDistance then
            bone, coords, distance = element, boneCoords, boneDistance
        end
    end
    if not bone then
        bone = {id = GetEntityBoneIndexByName(entity, "bodyshell"), type = "remains", name = "bodyshell"}
        coords = GetWorldPositionOfEntityBone(entity, bone.id)
        distance = #(coords - playerCoords)
    end
    return bone, coords, distance
end

function QBCore.Functions.GetBoneDistance(entity, boneType, boneIndex)
    local bone
    if boneType == 1 then
        bone = GetPedBoneIndex(entity, boneIndex)
    else
        bone = GetEntityBoneIndexByName(entity, boneIndex)
    end
    local boneCoords = GetWorldPositionOfEntityBone(entity, bone)
    local playerCoords = GetEntityCoords(PlayerPedId())
    return #(boneCoords - playerCoords)
end

function QBCore.Functions.AttachProp(ped, model, boneId, x, y, z, xR, yR, zR, vertex)
    local modelHash = type(model) == 'string' and GetHashKey(model) or model
    local bone = GetPedBoneIndex(ped, boneId)
    QBCore.Functions.LoadModel(modelHash)
    local prop = CreateObject(modelHash, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(prop, ped, bone, x, y, z, xR, yR, zR, 1, 1, 0, 1, not vertex and 2 or 0, 1)
    SetModelAsNoLongerNeeded(modelHash)
    return prop
end

-- Vehicle

function QBCore.Functions.SpawnVehicle(model, cb, coords, isnetworked, teleportInto)
    local ped = PlayerPedId()
    model = type(model) == 'string' and GetHashKey(model) or model
    if not IsModelInCdimage(model) then return end
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    isnetworked = isnetworked or true
    QBCore.Functions.LoadModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, isnetworked, false)
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

function QBCore.Functions.DeleteVehicle(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
end

function QBCore.Functions.GetPlate(vehicle)
    if vehicle == 0 then return end
    return QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
end

function QBCore.Functions.SpawnClear(coords, radius)
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(PlayerPedId())
    end
    local vehicles = GetGamePool('CVehicle')
    local closeVeh = {}
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)
        if distance <= radius then
            closeVeh[#closeVeh + 1] = vehicles[i]
        end
    end
    if #closeVeh > 0 then return false end
    return true
end

function QBCore.Functions.GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        if GetIsVehiclePrimaryColourCustom(vehicle) then
            r, g, b = GetVehicleCustomPrimaryColour(vehicle)
            colorPrimary = {r, g, b}
        end

        if GetIsVehicleSecondaryColourCustom(vehicle) then
            r, g, b = GetVehicleCustomSecondaryColour(vehicle)
            colorSecondary = {r, g, b}
        end

        local extras = {}
        for extraId = 0, 12 do
            if DoesExtraExist(vehicle, extraId) then
                local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
                extras[tostring(extraId)] = state
            end
        end

        local modLivery = GetVehicleMod(vehicle, 48)
        if GetVehicleMod(vehicle, 48) == -1 and GetVehicleLivery(vehicle) ~= 0 then
            modLivery = GetVehicleLivery(vehicle)
        end

        local neons = {}
        for i = 0, 3 do
            neons[i] = IsVehicleNeonLightEnabled(vehicle, i)
        end

        local tireHealth = {}
        for i = 0, 3 do
            tireHealth[i] = GetVehicleWheelHealth(vehicle, i)
        end

        local tireBurstState = {}
        for i = 0, 5 do
           tireBurstState[i] = IsVehicleTyreBurst(vehicle, i, false)
        end

        local tireBurstCompletely = {}
        for i = 0, 5 do
            tireBurstCompletely[i] = IsVehicleTyreBurst(vehicle, i, true)
        end

        local windowStatus = {}
        for i = 0, 7 do
            windowStatus[i] = IsVehicleWindowIntact(vehicle, i) == 1
        end

        local doorStatus = {}
        for i = 0, 5 do
            doorStatus[i] = IsVehicleDoorDamaged(vehicle, i) == 1
        end

        return {
            model = GetEntityModel(vehicle),
            plate = QBCore.Functions.GetPlate(vehicle),
            plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
            bodyHealth = QBCore.Shared.Round(GetVehicleBodyHealth(vehicle), 0.1),
            engineHealth = QBCore.Shared.Round(GetVehicleEngineHealth(vehicle), 0.1),
            tankHealth = QBCore.Shared.Round(GetVehiclePetrolTankHealth(vehicle), 0.1),
            fuelLevel = QBCore.Shared.Round(GetVehicleFuelLevel(vehicle), 0.1),
            dirtLevel = QBCore.Shared.Round(GetVehicleDirtLevel(vehicle), 0.1),
            oilLevel = QBCore.Shared.Round(GetVehicleOilLevel(vehicle), 0.1),
            color1 = colorPrimary,
            color2 = colorSecondary,
            pearlescentColor = pearlescentColor,
            dashboardColor = GetVehicleDashboardColour(vehicle),
            wheelColor = wheelColor,
            wheels = GetVehicleWheelType(vehicle),
            wheelSize = GetVehicleWheelSize(vehicle),
            wheelWidth = GetVehicleWheelWidth(vehicle),
            tireHealth = tireHealth,
            tireBurstState = tireBurstState,
            tireBurstCompletely = tireBurstCompletely,
            windowTint = GetVehicleWindowTint(vehicle),
            windowStatus = windowStatus,
            doorStatus = doorStatus,
            xenonColor = GetVehicleXenonLightsColour(vehicle),
            neonEnabled = neons,
            neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
            headlightColor = GetVehicleHeadlightsColour(vehicle),
            interiorColor = GetVehicleInteriorColour(vehicle),
            extras = extras,
            tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),
            modSpoilers = GetVehicleMod(vehicle, 0),
            modFrontBumper = GetVehicleMod(vehicle, 1),
            modRearBumper = GetVehicleMod(vehicle, 2),
            modSideSkirt = GetVehicleMod(vehicle, 3),
            modExhaust = GetVehicleMod(vehicle, 4),
            modFrame = GetVehicleMod(vehicle, 5),
            modGrille = GetVehicleMod(vehicle, 6),
            modHood = GetVehicleMod(vehicle, 7),
            modFender = GetVehicleMod(vehicle, 8),
            modRightFender = GetVehicleMod(vehicle, 9),
            modRoof = GetVehicleMod(vehicle, 10),
            modEngine = GetVehicleMod(vehicle, 11),
            modBrakes = GetVehicleMod(vehicle, 12),
            modTransmission = GetVehicleMod(vehicle, 13),
            modHorns = GetVehicleMod(vehicle, 14),
            modSuspension = GetVehicleMod(vehicle, 15),
            modArmor = GetVehicleMod(vehicle, 16),
            modKit17 = GetVehicleMod(vehicle, 17),
            modTurbo = IsToggleModOn(vehicle, 18),
            modKit19 = GetVehicleMod(vehicle, 19),
            modSmokeEnabled = IsToggleModOn(vehicle, 20),
            modKit21 = GetVehicleMod(vehicle, 21),
            modXenon = IsToggleModOn(vehicle, 22),
            modFrontWheels = GetVehicleMod(vehicle, 23),
            modBackWheels = GetVehicleMod(vehicle, 24),
            modCustomTiresF = GetVehicleModVariation(vehicle, 23),
            modCustomTiresR = GetVehicleModVariation(vehicle, 24),
            modPlateHolder = GetVehicleMod(vehicle, 25),
            modVanityPlate = GetVehicleMod(vehicle, 26),
            modTrimA = GetVehicleMod(vehicle, 27),
            modOrnaments = GetVehicleMod(vehicle, 28),
            modDashboard = GetVehicleMod(vehicle, 29),
            modDial = GetVehicleMod(vehicle, 30),
            modDoorSpeaker = GetVehicleMod(vehicle, 31),
            modSeats = GetVehicleMod(vehicle, 32),
            modSteeringWheel = GetVehicleMod(vehicle, 33),
            modShifterLeavers = GetVehicleMod(vehicle, 34),
            modAPlate = GetVehicleMod(vehicle, 35),
            modSpeakers = GetVehicleMod(vehicle, 36),
            modTrunk = GetVehicleMod(vehicle, 37),
            modHydrolic = GetVehicleMod(vehicle, 38),
            modEngineBlock = GetVehicleMod(vehicle, 39),
            modAirFilter = GetVehicleMod(vehicle, 40),
            modStruts = GetVehicleMod(vehicle, 41),
            modArchCover = GetVehicleMod(vehicle, 42),
            modAerials = GetVehicleMod(vehicle, 43),
            modTrimB = GetVehicleMod(vehicle, 44),
            modTank = GetVehicleMod(vehicle, 45),
            modWindows = GetVehicleMod(vehicle, 46),
            modKit47 = GetVehicleMod(vehicle, 47),
            modLivery = modLivery,
            modKit49 = GetVehicleMod(vehicle, 49),
            liveryRoof = GetVehicleRoofLivery(vehicle),
        }
    else
        return
    end
end

function QBCore.Functions.SetVehicleProperties(vehicle, props)
    if DoesEntityExist(vehicle) then
        if props.extras then
            for id, enabled in pairs(props.extras) do
                if enabled then
                    SetVehicleExtra(vehicle, tonumber(id), 0)
                else
                    SetVehicleExtra(vehicle, tonumber(id), 1)
                end
            end
        end

        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        SetVehicleModKit(vehicle, 0)
        if props.plate then
            SetVehicleNumberPlateText(vehicle, props.plate)
        end
        if props.plateIndex then
            SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
        end
        if props.bodyHealth then
            SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
        end
        if props.engineHealth then
            SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
        end
        if props.tankHealth then
            SetVehiclePetrolTankHealth(vehicle, props.tankHealth)
        end
        if props.fuelLevel then
            SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
        end
        if props.dirtLevel then
            SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
        end
        if props.oilLevel then
            SetVehicleOilLevel(vehicle, props.oilLevel)
        end
        if props.color1 then
            if type(props.color1) == "number" then
                SetVehicleColours(vehicle, props.color1, colorSecondary)
            else
                SetVehicleCustomPrimaryColour(vehicle, props.color1[1], props.color1[2], props.color1[3])
            end
        end
        if props.color2 then
            if type(props.color2) == "number" then
                SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2)
            else
                SetVehicleCustomSecondaryColour(vehicle, props.color2[1], props.color2[2], props.color2[3])
            end
        end
        if props.pearlescentColor then
            SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
        end
        if props.interiorColor then
            SetVehicleInteriorColor(vehicle, props.interiorColor)
        end
        if props.dashboardColor then
            SetVehicleDashboardColour(vehicle, props.dashboardColor)
        end
        if props.wheelColor then
            SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor)
        end
        if props.wheels then
            SetVehicleWheelType(vehicle, props.wheels)
        end
        if props.tireHealth then
            for wheelIndex, health in pairs(props.tireHealth) do
                SetVehicleWheelHealth(vehicle, wheelIndex, health)
            end
        end
        if props.tireBurstState then
            for wheelIndex, burstState in pairs(props.tireBurstState) do
                if burstState then
                    SetVehicleTyreBurst(vehicle, tonumber(wheelIndex), false, 1000.0)
                end
            end
        end
        if props.tireBurstCompletely then
            for wheelIndex, burstState in pairs(props.tireBurstCompletely) do
                if burstState then
                    SetVehicleTyreBurst(vehicle, tonumber(wheelIndex), true, 1000.0)
                end
            end
        end
        if props.windowTint then
            SetVehicleWindowTint(vehicle, props.windowTint)
        end
        if props.windowStatus then
            for windowIndex, smashWindow in pairs(props.windowStatus) do
                if not smashWindow then SmashVehicleWindow(vehicle, windowIndex) end
            end
        end
        if props.doorStatus then
            for doorIndex, breakDoor in pairs(props.doorStatus) do
                if breakDoor then
                    SetVehicleDoorBroken(vehicle, doorIndex, true)
                end
            end
        end
        if props.neonEnabled then
            for neonIndex, enableNeons in pairs(props.neonEnabled) do
                SetVehicleNeonLightEnabled(vehicle, neonIndex, enableNeons)
            end
        end
        if props.neonColor then
            SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
        end
        if props.headlightColor then
            SetVehicleHeadlightsColour(vehicle, props.headlightColor)
        end
        if props.interiorColor then
            SetVehicleInteriorColour(vehicle, props.interiorColor)
        end
        if props.wheelSize then
            SetVehicleWheelSize(vehicle, props.wheelSize)
        end
        if props.wheelWidth then
            SetVehicleWheelWidth(vehicle, props.wheelWidth)
        end
        if props.tyreSmokeColor then
            SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
        end
        if props.modSpoilers then
            SetVehicleMod(vehicle, 0, props.modSpoilers, false)
        end
        if props.modFrontBumper then
            SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
        end
        if props.modRearBumper then
            SetVehicleMod(vehicle, 2, props.modRearBumper, false)
        end
        if props.modSideSkirt then
            SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
        end
        if props.modExhaust then
            SetVehicleMod(vehicle, 4, props.modExhaust, false)
        end
        if props.modFrame then
            SetVehicleMod(vehicle, 5, props.modFrame, false)
        end
        if props.modGrille then
            SetVehicleMod(vehicle, 6, props.modGrille, false)
        end
        if props.modHood then
            SetVehicleMod(vehicle, 7, props.modHood, false)
        end
        if props.modFender then
            SetVehicleMod(vehicle, 8, props.modFender, false)
        end
        if props.modRightFender then
            SetVehicleMod(vehicle, 9, props.modRightFender, false)
        end
        if props.modRoof then
            SetVehicleMod(vehicle, 10, props.modRoof, false)
        end
        if props.modEngine then
            SetVehicleMod(vehicle, 11, props.modEngine, false)
        end
        if props.modBrakes then
            SetVehicleMod(vehicle, 12, props.modBrakes, false)
        end
        if props.modTransmission then
            SetVehicleMod(vehicle, 13, props.modTransmission, false)
        end
        if props.modHorns then
            SetVehicleMod(vehicle, 14, props.modHorns, false)
        end
        if props.modSuspension then
            SetVehicleMod(vehicle, 15, props.modSuspension, false)
        end
        if props.modArmor then
            SetVehicleMod(vehicle, 16, props.modArmor, false)
        end
        if props.modKit17 then
            SetVehicleMod(vehicle, 17, props.modKit17, false)
        end
        if props.modTurbo then
            ToggleVehicleMod(vehicle, 18, props.modTurbo)
        end
        if props.modKit19 then
            SetVehicleMod(vehicle, 19, props.modKit19, false)
        end
        if props.modSmokeEnabled then
            ToggleVehicleMod(vehicle, 20, props.modSmokeEnabled)
        end
        if props.modKit21 then
            SetVehicleMod(vehicle, 21, props.modKit21, false)
        end
        if props.modXenon then
            ToggleVehicleMod(vehicle, 22, props.modXenon)
        end
        if props.xenonColor then
            SetVehicleXenonLightsColor(vehicle, props.xenonColor)
        end
        if props.modFrontWheels then
            SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
        end
        if props.modBackWheels then
            SetVehicleMod(vehicle, 24, props.modBackWheels, false)
        end
        if props.modCustomTiresF then
            SetVehicleMod(vehicle, 23, props.modFrontWheels, props.modCustomTiresF)
        end
        if props.modCustomTiresR then
            SetVehicleMod(vehicle, 24, props.modBackWheels, props.modCustomTiresR)
        end
        if props.modPlateHolder then
            SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
        end
        if props.modVanityPlate then
            SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
        end
        if props.modTrimA then
            SetVehicleMod(vehicle, 27, props.modTrimA, false)
        end
        if props.modOrnaments then
            SetVehicleMod(vehicle, 28, props.modOrnaments, false)
        end
        if props.modDashboard then
            SetVehicleMod(vehicle, 29, props.modDashboard, false)
        end
        if props.modDial then
            SetVehicleMod(vehicle, 30, props.modDial, false)
        end
        if props.modDoorSpeaker then
            SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
        end
        if props.modSeats then
            SetVehicleMod(vehicle, 32, props.modSeats, false)
        end
        if props.modSteeringWheel then
            SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
        end
        if props.modShifterLeavers then
            SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
        end
        if props.modAPlate then
            SetVehicleMod(vehicle, 35, props.modAPlate, false)
        end
        if props.modSpeakers then
            SetVehicleMod(vehicle, 36, props.modSpeakers, false)
        end
        if props.modTrunk then
            SetVehicleMod(vehicle, 37, props.modTrunk, false)
        end
        if props.modHydrolic then
            SetVehicleMod(vehicle, 38, props.modHydrolic, false)
        end
        if props.modEngineBlock then
            SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
        end
        if props.modAirFilter then
            SetVehicleMod(vehicle, 40, props.modAirFilter, false)
        end
        if props.modStruts then
            SetVehicleMod(vehicle, 41, props.modStruts, false)
        end
        if props.modArchCover then
            SetVehicleMod(vehicle, 42, props.modArchCover, false)
        end
        if props.modAerials then
            SetVehicleMod(vehicle, 43, props.modAerials, false)
        end
        if props.modTrimB then
            SetVehicleMod(vehicle, 44, props.modTrimB, false)
        end
        if props.modTank then
            SetVehicleMod(vehicle, 45, props.modTank, false)
        end
        if props.modWindows then
            SetVehicleMod(vehicle, 46, props.modWindows, false)
        end
        if props.modKit47 then
            SetVehicleMod(vehicle, 47, props.modKit47, false)
        end
        if props.modLivery then
            SetVehicleMod(vehicle, 48, props.modLivery, false)
            SetVehicleLivery(vehicle, props.modLivery)
        end
        if props.modKit49 then
            SetVehicleMod(vehicle, 49, props.modKit49, false)
        end
        if props.liveryRoof then
            SetVehicleRoofLivery(vehicle, props.liveryRoof)
        end
    end
end

function QBCore.Functions.LoadParticleDictionary(dictionary)
    if HasNamedPtfxAssetLoaded(dictionary) then return end
    RequestNamedPtfxAsset(dictionary)
    while not HasNamedPtfxAssetLoaded(dictionary) do
        Wait(0)
    end
end

function QBCore.Functions.StartParticleAtCoord(dict, ptName, looped, coords, rot, scale, alpha, color, duration)
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(PlayerPedId())
    end
    QBCore.Functions.LoadParticleDictionary(dict)
    UseParticleFxAssetNextCall(dict)
    SetPtfxAssetNextCall(dict)
    local particleHandle
    if looped then
        particleHandle = StartParticleFxLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0)
        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end
        SetParticleFxLoopedAlpha(particleHandle, alpha or 10.0)
        if duration then
            Wait(duration)
            StopParticleFxLooped(particleHandle, 0)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)
        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end
        StartParticleFxNonLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0)
    end
    return particleHandle
end

function QBCore.Functions.StartParticleOnEntity(dict, ptName, looped, entity, bone, offset, rot, scale, alpha, color, evolution, duration)
    QBCore.Functions.LoadParticleDictionary(dict)
    UseParticleFxAssetNextCall(dict)
    local particleHandle, boneID
    if bone and GetEntityType(entity) == 1 then
        boneID = GetPedBoneIndex(entity, bone)
    elseif bone then
        boneID = GetEntityBoneIndexByName(entity, bone)
    end
    if looped then
        if bone then
            particleHandle = StartParticleFxLoopedOnEntityBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale)
        else
            particleHandle = StartParticleFxLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
        end
        if evolution then
            SetParticleFxLoopedEvolution(particleHandle, evolution.name, evolution.amount, false)
        end
        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end
        SetParticleFxLoopedAlpha(particleHandle, alpha)
        if duration then
            Wait(duration)
            StopParticleFxLooped(particleHandle, 0)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)
        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end
        if bone then
            StartParticleFxNonLoopedOnPedBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale)
        else
            StartParticleFxNonLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
        end
    end
    return particleHandle
end

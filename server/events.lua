--[[
Credit to Frazzle for the Password Adapative Card Code.

link to the repo: https://gist.github.com/FrazzIe/f59813c137496cd94657e6de909775aa
--]]

-- Event Handler

AddEventHandler('chatMessage', function(_, _, message)
    if string.sub(message, 1, 1) == '/' then
        CancelEvent()
        return
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if not QBCore.Players[src] then return end
    local Player = QBCore.Players[src]
    TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Dropped', 'red', '**' .. GetPlayerName(src) .. '** (' .. Player.PlayerData.license .. ') left..' ..'\n **Reason:** ' .. reason)
    Player.Functions.Save()
    QBCore.Player_Buckets[Player.PlayerData.license] = nil
    QBCore.Players[src] = nil
end)

-- Player Connecting
local function onPlayerConnecting(name, _, deferrals)
    local src = source
    local license
    local identifiers = GetPlayerIdentifiers(src)
    deferrals.defer()

    -- Mandatory wait
    Wait(0)

    local allowed = QBCore.Functions.HasPermission(src, QBCore.Config.Server.ClosedWhitelist)

    if QBCore.Config.Server.Closed and not QBCore.Config.Server.MaintenanceMode then
        if not allowed then
            deferrals.done(Lang:t('error.server_currently_closed'))
        end
    end

    deferrals.update(string.format(Lang:t('info.checking_ban'), name))

    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    -- Mandatory wait
    Wait(2000)

    deferrals.update(string.format(Lang:t('info.checking_whitelisted'), name))

    local isBanned, Reason = QBCore.Functions.IsPlayerBanned(src)
    local isLicenseAlreadyInUse = QBCore.Functions.IsLicenseInUse(license)
    local isWhitelist, whitelisted = QBCore.Config.Server.Whitelist, QBCore.Functions.IsWhitelisted(src)

    Wait(2000)

    if not license then
        deferrals.done(Lang:t('error.no_valid_license'))
    elseif isBanned then
        deferrals.done(Reason)
    elseif isLicenseAlreadyInUse and QBCore.Config.Server.CheckDuplicateLicense then
        deferrals.done(Lang:t('error.duplicate_license'))
    elseif isWhitelist and not whitelisted then
        deferrals.done(Lang:t('error.not_whitelisted'))
    end

    Wait(1000)

    -- Add any additional defferals you may need here!

    if QBCore.Config.Server.Password.Required and not allowed then
        local function PasswordDefferal(data)
            local match = false

            if data then
                if data.password then
                    if not QBCore.Config.Server.MaintenanceMode then
                        if data.password == QBCore.Config.Server.Password.String then
                            match = true
                        end
                    else
                        if data.password == QBCore.Config.Server.MaintenanceModePassword then
                            match = true
                        end
                    end
                end
            end

            if not match then
                if not QBCore.Config.Server.Password.Attempts[src] then
                    QBCore.Config.Server.Password.Attempts[src] = 0
                else
                    QBCore.Config.Server.Password.Attempts[src] = QBCore.Config.Server.Password.Attempts[src] + 1
                end

                if QBCore.Config.Server.Password.Attempts[src] < 3 then
                    DisplayPasswordCard(deferrals, PasswordDefferal, true, QBCore.Config.Server.Password.Attempts[src])
                else
                    deferrals.done(Lang:t('error.password_error'))
                end
            else
                deferrals.update(string.format(Lang:t('info.join_server'), QBCore.Config.ServerName))
                Wait(1000)
                deferrals.done()
            end
        end

        DisplayPasswordCard(deferrals, PasswordDefferal)
    else
        deferrals.update(string.format(Lang:t('info.join_server'), QBCore.Config.ServerName))
        Wait(1000)
        deferrals.done()
    end
end

-- Adapative Card logic for defferals
function DisplayPasswordCard(deferrals, callback, showError, numAttempts)
	local card = QBCore.Config.Server.Password.Card

	card.body[1].items[3].isVisible = showError and true or false
    card.actions[1].title = string.format(Lang:t('info.password_submit'))
    card.body[1].items[2].text = string.format(Lang:t('info.password_prompt'))

    if QBCore.Config.Server.MaintenanceMode then
        card.body[1].items[1].text = string.format(Lang:t('info.password_header_maintenance'))
    else
        card.body[1].items[1].text = string.format(Lang:t('info.password_header_normal'))
    end



	if showError and numAttempts then
		card.body[1].items[3].items[1].text = string.format(Lang:t('error.password_error_attempts', {attempts = (3 - numAttempts)}))
	end

	deferrals.presentCard(card, callback)
end

AddEventHandler('playerConnecting', onPlayerConnecting)

-- Open & Close Server (prevents players from joining)
function KickAllPlayers(reason)
    for player in pairs(QBCore.Players) do
        if not QBCore.Functions.HasPermission(player, QBCore.Config.Server.ClosedWhitelist) then
            QBCore.Functions.Kick(player, reason, nil, nil)
        end
    end
end

RegisterNetEvent('QBCore:Server:CloseServer', function(reason)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        reason = reason or 'No reason specified'
        QBCore.Config.Server.Closed = true
        QBCore.Config.Server.ClosedReason = reason
        KickAllPlayers(reason)
    else
        QBCore.Functions.Kick(src, Lang:t("error.no_permission"), nil, nil)
    end
end)

RegisterNetEvent('QBCore:Server:OpenServer', function()
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        QBCore.Config.Server.Closed = false
    else
        QBCore.Functions.Kick(src, Lang:t("error.no_permission"), nil, nil)
    end
end)

-- Toggle and Set Server Password (prevent normal players from joining unless they have the password)
RegisterNetEvent('QBCore:Server:TogglePassword', function()
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        QBCore.Config.Server.Password.Required = not QBCore.Config.Server.Password.Required
    else
        QBCore.Functions.Kick(src, Lang:t("error.no_permission"), nil, nil)
    end
end)

RegisterNetEvent('QBCore:Server:SetPassword', function(value)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        if type(value) == "string" then
            QBCore.Config.Server.Password.String = value
        end
    else
        QBCore.Functions.Kick(src, Lang:t("error.no_permission"), nil, nil)
    end
end)

RegisterNetEvent('QBCore:Server:GetMaintenanceMode', function()
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
            return QBCore.Config.Server.MaintenanceMode
    else
        QBCore.Functions.Kick(src, Lang:t("error.no_permission"), nil, nil)
    end
end)

RegisterNetEvent('QBCore:Server:ToggleMaintenanceMode', function(value)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        if QBCore.Config.Server.MaintenanceMode then
            if type(value) == "string" then
                QBCore.Config.Server.MaintenanceMode = true
                QBCore.Config.Server.MaintenanceModePassword = value
                KickAllPlayers(Lang:t("info.enter_maintenance_mode"))
            else
                QBCore.Config.Server.MaintenanceMode = false
                QBCore.Config.Server.MaintenanceModePassword = ""
            end
        else
            QBCore.Config.Server.MaintenanceModePassword = ""
        end
    else
        QBCore.Functions.Kick(src, Lang:t("error.no_permission"), nil, nil)
    end
end)

-- Callback Events --

-- Client Callback
RegisterNetEvent('QBCore:Server:TriggerClientCallback', function(name, ...)
    if QBCore.ClientCallbacks[name] then
        QBCore.ClientCallbacks[name](...)
        QBCore.ClientCallbacks[name] = nil
    end
end)

-- Server Callback
RegisterNetEvent('QBCore:Server:TriggerCallback', function(name, ...)
    local src = source
    QBCore.Functions.TriggerCallback(name, src, function(...)
        TriggerClientEvent('QBCore:Client:TriggerCallback', src, name, ...)
    end, ...)
end)

-- Player

RegisterNetEvent('QBCore:UpdatePlayer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local newHunger = Player.PlayerData.metadata['hunger'] - QBCore.Config.Player.HungerRate
    local newThirst = Player.PlayerData.metadata['thirst'] - QBCore.Config.Player.ThirstRate
    if newHunger <= 0 then
        newHunger = 0
    end
    if newThirst <= 0 then
        newThirst = 0
    end
    Player.Functions.SetMetaData('thirst', newThirst)
    Player.Functions.SetMetaData('hunger', newHunger)
    TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
    Player.Functions.Save()
end)

RegisterNetEvent('QBCore:Server:SetMetaData', function(meta, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if meta == 'hunger' or meta == 'thirst' then
        if data > 100 then
            data = 100
        end
    end
    Player.Functions.SetMetaData(meta, data)
    TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata['hunger'], Player.PlayerData.metadata['thirst'])
end)

RegisterNetEvent('QBCore:ToggleDuty', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.onduty then
        Player.Functions.SetJobDuty(false)
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.off_duty'))
    else
        Player.Functions.SetJobDuty(true)
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.on_duty'))
    end
    TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
end)

-- Items

-- This event is exploitable and should not be used. It has been deprecated, and will be removed soon.
RegisterNetEvent('QBCore:Server:UseItem', function(item)
    print(string.format("%s triggered QBCore:Server:UseItem by ID %s with the following data. This event is deprecated due to exploitation, and will be removed soon. Check qb-inventory for the right use on this event.", GetInvokingResource(), source))
    QBCore.Debug(item)
end)

-- This event is exploitable and should not be used. It has been deprecated, and will be removed soon. function(itemName, amount, slot)
RegisterNetEvent('QBCore:Server:RemoveItem', function(itemName, amount)
    local src = source
    print(string.format("%s triggered QBCore:Server:RemoveItem by ID %s for %s %s. This event is deprecated due to exploitation, and will be removed soon. Adjust your events accordingly to do this server side with player functions.", GetInvokingResource(), src, amount, itemName))
end)

-- This event is exploitable and should not be used. It has been deprecated, and will be removed soon. function(itemName, amount, slot, info)
RegisterNetEvent('QBCore:Server:AddItem', function(itemName, amount)
    local src = source
    print(string.format("%s triggered QBCore:Server:AddItem by ID %s for %s %s. This event is deprecated due to exploitation, and will be removed soon. Adjust your events accordingly to do this server side with player functions.", GetInvokingResource(), src, amount, itemName))
end)

-- Non-Chat Command Calling (ex: qb-adminmenu)

RegisterNetEvent('QBCore:CallCommand', function(command, args)
    local src = source
    if not QBCore.Commands.List[command] then return end
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local hasPerm = QBCore.Functions.HasPermission(src, "command."..QBCore.Commands.List[command].name)
    if hasPerm then
        if QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and not args[#QBCore.Commands.List[command].arguments] then
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.missing_args2'), 'error')
        else
            QBCore.Commands.List[command].callback(src, args)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_access'), 'error')
    end
end)

-- Use this for player vehicle spawning
-- Vehicle server-side spawning callback (netId)
-- use the netid on the client with the NetworkGetEntityFromNetworkId native
-- convert it to a vehicle via the NetToVeh native
QBCore.Functions.CreateCallback('QBCore:Server:SpawnVehicle', function(source, cb, model, coords, warp)
    local ped = GetPlayerPed(source)
    model = type(model) == 'string' and joaat(model) or model
    if not coords then coords = GetEntityCoords(ped) end
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, true)
    while not DoesEntityExist(veh) do Wait(0) end
    if warp then
        while GetVehiclePedIsIn(ped) ~= veh do
            Wait(0)
            TaskWarpPedIntoVehicle(ped, veh, -1)
        end
    end
    while NetworkGetEntityOwner(veh) ~= source do Wait(0) end
    cb(NetworkGetNetworkIdFromEntity(veh))
end)

-- Use this for long distance vehicle spawning
-- vehicle server-side spawning callback (netId)
-- use the netid on the client with the NetworkGetEntityFromNetworkId native
-- convert it to a vehicle via the NetToVeh native
QBCore.Functions.CreateCallback('QBCore:Server:CreateVehicle', function(source, cb, model, coords, warp)
    model = type(model) == 'string' and GetHashKey(model) or model
    if not coords then coords = GetEntityCoords(GetPlayerPed(source)) end
    local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")
    local veh = Citizen.InvokeNative(CreateAutomobile, model, coords, coords.w, true, true)
    while not DoesEntityExist(veh) do Wait(0) end
    if warp then TaskWarpPedIntoVehicle(GetPlayerPed(source), veh, -1) end
    cb(NetworkGetNetworkIdFromEntity(veh))
end)

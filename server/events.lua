-- Event Handler

AddEventHandler('chatMessage', function(source, _, message)
    if string.sub(message, 1, 1) == '/' then
        CancelEvent()
        return
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    if not QBCore.Players[src] then return end
    local Player = QBCore.Players[src]
    TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Dropped', 'red', '**' .. GetPlayerName(src) .. '** (' .. Player.PlayerData.license .. ') left..')
    Player.Functions.Save()
    QBCore.Player_Buckets[Player.PlayerData.license] = nil
    QBCore.Players[src] = nil
end)

-- Player Connecting

local function onPlayerConnecting(name, setKickReason, deferrals)
    local src = source
    local license
    local identifiers = GetPlayerIdentifiers(src)
    deferrals.defer()

    -- Mandatory wait
    Wait(0)

    if QBCore.Config.Server.Closed then
        if not IsPlayerAceAllowed(src, 'qbadmin.join') then
            deferrals.done(QBCore.Config.Server.ClosedReason)
        end
    end

    deferrals.update(string.format('Hello %s. Validating Your Rockstar License', name))

    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    -- Mandatory wait
    Wait(2500)

    deferrals.update(string.format('Hello %s. We are checking your allowance.', name))

    local isBanned, Reason = QBCore.Functions.IsPlayerBanned(src)
    local isLicenseAlreadyInUse = QBCore.Functions.IsLicenseInUse(license)
    local isWhitelist, whitelisted = QBCore.Config.Server.Whitelist, QBCore.Functions.IsWhitelisted(src)

    Wait(2500)

    deferrals.update(string.format('Welcome %s to {Server Name}.', name))

    if not license then
        deferrals.done('No Valid Rockstar License Found')
    elseif isBanned then
        deferrals.done(Reason)
    elseif isLicenseAlreadyInUse and QBCore.Config.Server.CheckDuplicateLicense then
        deferrals.done('Duplicate Rockstar License Found')
    elseif isWhitelist and not whitelisted then
        deferrals.done('You\'re not whitelisted for this server')
    else
        deferrals.done()
        if QBCore.Config.Server.UseConnectQueue then
            Wait(1000)
            TriggerEvent('connectqueue:playerConnect', name, setKickReason, deferrals)
        end
    end
    -- Add any additional defferals you may need!
end

AddEventHandler('playerConnecting', onPlayerConnecting)

-- Open & Close Server (prevents players from joining)

RegisterNetEvent('QBCore:Server:CloseServer', function(reason)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        reason = reason or 'No reason specified'
        QBCore.Config.Server.Closed = true
        QBCore.Config.Server.ClosedReason = reason
        for k in pairs(QBCore.Players) do
            if not QBCore.Functions.HasPermission(k, QBCore.Config.Server.WhitelistPermission) then
                QBCore.Functions.Kick(k, reason, nil, nil)
            end
        end
    else
        QBCore.Functions.Kick(src, 'You don\'t have permissions for this..', nil, nil)
    end
end)

RegisterNetEvent('QBCore:Server:OpenServer', function()
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        QBCore.Config.Server.Closed = false
    else
        QBCore.Functions.Kick(src, 'You don\'t have permissions for this..', nil, nil)
    end
end)

-- Callbacks

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
    if meta == 'hunger' or meta == 'thirst' then
        if data > 100 then
            data = 100
        end
    end
    if Player then
        Player.Functions.SetMetaData(meta, data)
    end
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

RegisterNetEvent('QBCore:Server:UseItem', function(item)
    local src = source
    if not item or item.amount <= 0 or not QBCore.Functions.CanUseItem(item.name) then return end
    QBCore.Functions.UseItem(src, item)
end)

RegisterNetEvent('QBCore:Server:RemoveItem', function(itemName, amount, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(itemName, amount, slot)
end)

RegisterNetEvent('QBCore:Server:AddItem', function(itemName, amount, slot, info)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem(itemName, amount, slot, info)
end)

-- Non-Chat Command Calling (ex: qb-adminmenu)

RegisterNetEvent('QBCore:CallCommand', function(command, args)
    local src = source
    if not QBCore.Commands.List[command] then return end
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
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

-- Has Item Callback (can also use client function - QBCore.Functions.HasItem(item))

QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, items, amount)
    local retval = false
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb(false) end
    if type(items) == 'table' then
        local count = 0
        local finalcount = 0
        for k, v in pairs(items) do
            if type(k) == 'string' then
                finalcount = 0
                for i, _ in pairs(items) do finalcount += 1 end
                local item = Player.Functions.GetItemByName(k)
                if item then
                    if item.amount >= v then
                        count += 1
                        if count == finalcount then
                            retval = true
                        end
                    end
                end
            else
                finalcount = #items
                local item = Player.Functions.GetItemByName(v)
                if item then
                    if amount then
                        if item.amount >= amount then
                            count += 1
                            if count == finalcount then
                                retval = true
                            end
                        end
                    else
                        count += 1
                        if count == finalcount then
                            retval = true
                        end
                    end
                end
            end
        end
    else
        local item = Player.Functions.GetItemByName(items)
        if not item then return cb(false) end
        if amount then
            if item.amount >= amount then
                retval = true
            end
        else
            retval = true
        end
    end
    cb(retval)
end)

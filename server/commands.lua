QBCore.Commands = {}
QBCore.Commands.List = {}
QBCore.Commands.IgnoreList = { -- Ignore old perm levels while keeping backwards compatibility
    ['god'] = true, -- We don't need to create an ace because god is allowed all commands
    ['user'] = true -- We don't need to create an ace because builtin.everyone
}

CreateThread(function() -- Add ace to node for perm checking
    for k,v in pairs(QBConfig.Server.Permissions) do
        ExecuteCommand(('add_ace qbcore.%s %s allow'):format(v, v))
    end
end)

-- Register & Refresh Commands

function QBCore.Commands.Add(name, help, arguments, argsrequired, callback, permission)
    local restricted = true -- Default to restricted for all commands
    if not permission then permission = 'user' end -- some commands don't pass permission level
    if permission == 'user' then restricted = false end -- allow all users to use command
    RegisterCommand(name, callback, restricted) -- Register command within fivem
    if not QBCore.Commands.IgnoreList[permission] then -- only create aces for extra perm levels
        ExecuteCommand(('add_ace qbcore.%s command.%s allow'):format(permission, name))
    end
    QBCore.Commands.List[name:lower()] = {
        name = name:lower(),
        permission = tostring(permission:lower()),
        help = help,
        arguments = arguments,
        argsrequired = argsrequired,
        callback = callback
    }
end

function QBCore.Commands.Refresh(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local suggestions = {}
    if Player then
        for command, info in pairs(QBCore.Commands.List) do
            local hasPerm = IsPlayerAceAllowed(tostring(src), 'command.'..command)
            if hasPerm then
                suggestions[#suggestions + 1] = {
                    name = '/' .. command,
                    help = info.help,
                    params = info.arguments
                }
            else
                TriggerClientEvent('chat:removeSuggestion', src, '/'..command)
            end
        end
        TriggerClientEvent('chat:addSuggestions', src, suggestions)
    end
end

-- Teleport

QBCore.Commands.Add('tp', 'TP To Player or Coords (Admin Only)', { { name = 'id/x', help = 'ID of player or X position' }, { name = 'y', help = 'Y position' }, { name = 'z', help = 'Z position' } }, false, function(source, args)
    if args[1] and not args[2] and not args[3] then
        local target = GetPlayerPed(tonumber(args[1]))
        if target ~= 0 then
            local coords = GetEntityCoords(target)
            TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
        end
    else
        if args[1] and args[2] and args[3] then
            local x = tonumber(args[1])
            local y = tonumber(args[2])
            local z = tonumber(args[3])
            if x ~= 0 and y ~= 0 and z ~= 0 then
                TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t('error.wrong_format'), 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.missing_args'), 'error')
        end
    end
end, 'admin')

QBCore.Commands.Add('tpm', 'TP To Marker (Admin Only)', {}, false, function(source)
    TriggerClientEvent('QBCore:Command:GoToMarker', source)
end, 'admin')

QBCore.Commands.Add('togglepvp', 'Toggle PVP on the server (Admin Only)', {}, false, function()
    QBConfig.Server.PVP = not QBConfig.Server.PVP
    TriggerClientEvent('QBCore:Client:PvpHasToggled', -1, QBConfig.Server.PVP)
end, 'admin')

-- Permissions

QBCore.Commands.Add('addpermission', 'Give Player Permissions (God Only)', { { name = 'id', help = 'ID of player' }, { name = 'permission', help = 'Permission level' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local permission = tostring(args[2]):lower()
    if Player then
        QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'god')

QBCore.Commands.Add('removepermission', 'Remove Players Permissions (God Only)', { { name = 'id', help = 'ID of player' }, { name = 'permission', help = 'Permission level' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local permission = tostring(args[2]):lower()
    if Player then
        QBCore.Functions.RemovePermission(Player.PlayerData.source, permission)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'god')

-- Open & Close Server

QBCore.Commands.Add('openserver', 'Open the server for everyone (Admin Only)', {}, false, function(source)
    if not QBCore.Config.Server.Closed then
        TriggerClientEvent('QBCore:Notify', source, 'The server is already open', 'error')
        return
    end
    if QBCore.Functions.HasPermission(source, 'admin') then
        QBCore.Config.Server.Closed = false
    else
        QBCore.Functions.Kick(source, 'You don\'t have permissions for this..', nil, nil)
    end
end, 'admin')

QBCore.Commands.Add('closeserver', 'Close the server for people without permissions (Admin Only)', { { name = 'reason', help = 'Reason for closing it (optional)' } }, false, function(source, args)
    if QBCore.Config.Server.Closed then
        TriggerClientEvent('QBCore:Notify', source, 'The server is already closed', 'error')
        return
    end
    if QBCore.Functions.HasPermission(source, 'admin') then
        local reason = args[1] or 'No reason specified'
        QBCore.Config.Server.Closed = true
        QBCore.Config.Server.ClosedReason = reason
        for k in pairs(QBCore.Players) do
            if not QBCore.Functions.HasPermission(k, QBCore.Config.Server.WhitelistPermission) then
                QBCore.Functions.Kick(k, reason, nil, nil)
            end
        end
    else
        QBCore.Functions.Kick(source, 'You don\'t have permissions for this..', nil, nil)
    end
end, 'admin')

-- Vehicle

QBCore.Commands.Add('car', 'Spawn Vehicle (Admin Only)', { { name = 'model', help = 'Model name of the vehicle' } }, true, function(source, args)
    TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])
end, 'admin')

QBCore.Commands.Add('dv', 'Delete Vehicle (Admin Only)', {}, false, function(source)
    TriggerClientEvent('QBCore:Command:DeleteVehicle', source)
end, 'admin')

-- Money

QBCore.Commands.Add('givemoney', 'Give A Player Money (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

QBCore.Commands.Add('setmoney', 'Set Players Money Amount (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- Job

QBCore.Commands.Add('job', 'Check Your Job', {}, false, function(source)
    local PlayerJob = QBCore.Functions.GetPlayer(source).PlayerData.job
    TriggerClientEvent('QBCore:Notify', source, Lang:t('info.job_info', {value = PlayerJob.label, value2 = PlayerJob.grade.name, value3 = PlayerJob.onduty}))
end, 'user')

QBCore.Commands.Add('setjob', 'Set A Players Job (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'job', help = 'Job name' }, { name = 'grade', help = 'Grade' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- Gang

QBCore.Commands.Add('gang', 'Check Your Gang', {}, false, function(source)
    local PlayerGang = QBCore.Functions.GetPlayer(source).PlayerData.gang
    TriggerClientEvent('QBCore:Notify', source, Lang:t('info.gang_info', {value = PlayerGang.label, value2 = PlayerGang.grade.name}))
end, 'user')

QBCore.Commands.Add('setgang', 'Set A Players Gang (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'gang', help = 'Name of a gang' }, { name = 'grade', help = 'Grade' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetGang(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- Inventory (should be in qb-inventory?)

QBCore.Commands.Add('clearinv', 'Clear Players Inventory (Admin Only)', { { name = 'id', help = 'Player ID' } }, false, function(source, args)
    local playerId = args[1] and args[1] ~= '' or source
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player then
        Player.Functions.ClearInventory()
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- Out of Character Chat

QBCore.Commands.Add('ooc', 'OOC Chat Message', {}, false, function(source, args)
    local message = table.concat(args, ' ')
    local Players = QBCore.Functions.GetPlayers()
    local Player = QBCore.Functions.GetPlayer(source)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    for k, v in pairs(Players) do
        if v == source then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 0, 0, 255},
                multiline = true,
                args = {'OOC | '.. GetPlayerName(source), message}
            })
        elseif #(playerCoords - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 0, 0, 255},
                multiline = true,
                args = {'OOC | '.. GetPlayerName(source), message}
            })
        elseif QBCore.Functions.HasPermission(v, 'admin') then
            if QBCore.Functions.IsOptin(v) then
                TriggerClientEvent('chat:addMessage', v, {
                    color = { 0, 0, 255},
                    multiline = true,
                    args = {'Proxmity OOC | '.. GetPlayerName(source), message}
                })
                TriggerEvent('qb-log:server:CreateLog', 'ooc', 'OOC', 'white', '**' .. GetPlayerName(source) .. '** (CitizenID: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. source .. ') **Message:** ' .. message, false)
            end
        end
    end
end, 'user')

-- Me command

QBCore.Commands.Add('me', 'Show local message', {{name = 'message', help = 'Message to respond with'}}, false, function(source, args)
    local ped = GetPlayerPed(source)
    local pCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    if string.match(msg, "<") then TriggerClientEvent('QBCore:Notify', source, Lang:t('error.wrong_format'), 'error') return end
    for k,v in pairs(QBCore.Functions.GetPlayers()) do
        local target = GetPlayerPed(v)
        local tCoords = GetEntityCoords(target)
        if #(pCoords - tCoords) < 20 then
            TriggerClientEvent('QBCore:Command:ShowMe3D', v, source, msg)
        end
    end
end, 'user')

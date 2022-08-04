QBCore.Commands = {}
QBCore.Commands.List = {}
QBCore.Commands.IgnoreList = { -- Ignore old perm levels while keeping backwards compatibility
    ['god'] = true, -- We don't need to create an ace because god is allowed all commands
    ['user'] = true -- We don't need to create an ace because builtin.everyone
}

CreateThread(function() -- Add ace to node for perm checking
    for _, v in pairs(QBConfig.Server.Permissions) do
        ExecuteCommand(('add_ace qbcore.%s %s allow'):format(v, v))
    end
end)

-- Register & Refresh Commands

function QBCore.Commands.Add(name, help, arguments, argsrequired, callback, permission, ...)
    local restricted = true -- Default to restricted for all commands
    if not permission then permission = 'user' end -- some commands don't pass permission level
    if permission == 'user' then restricted = false end -- allow all users to use command

    RegisterCommand(name, function(source, args, rawCommand) -- Register command within fivem
        if argsrequired and #args < #arguments then
            return TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"System", Lang:t("error.missing_args2")}
            })
        end
        callback(source, args, rawCommand)
    end, restricted)

    local extraPerms = ... and table.pack(...) or nil
    if extraPerms then
        extraPerms[extraPerms.n + 1] = permission -- The `n` field is the number of arguments in the packed table
        extraPerms.n += 1
        permission = extraPerms
        for i = 1, permission.n do
            if not QBCore.Commands.IgnoreList[permission[i]] then -- only create aces for extra perm levels
                ExecuteCommand(('add_ace qbcore.%s command.%s allow'):format(permission[i], name))
            end
        end
        permission.n = nil
    else
        permission = tostring(permission:lower())
        if not QBCore.Commands.IgnoreList[permission] then -- only create aces for extra perm levels
            ExecuteCommand(('add_ace qbcore.%s command.%s allow'):format(permission, name))
        end
    end

    QBCore.Commands.List[name:lower()] = {
        name = name:lower(),
        permission = permission,
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

QBCore.Commands.Add('tp', Lang:t("comm.tp"), { { name = Lang:t("comm.tp_idx"), help = Lang:t("comm.tp_idx_h") }, { name = Lang:t("comm.tp_y"), help = Lang:t("comm.tp_y_h") }, { name = Lang:t("comm.tp_z"), help = Lang:t("comm.tp_z_h") } }, false, function(source, args)
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
            local x = tonumber((args[1]:gsub(",",""))) + .0
            local y = tonumber((args[2]:gsub(",",""))) + .0
            local z = tonumber((args[3]:gsub(",",""))) + .0
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

QBCore.Commands.Add('tpm', Lang:t("comm.tpm"), {}, false, function(source)
    TriggerClientEvent('QBCore:Command:GoToMarker', source)
end, 'admin')

QBCore.Commands.Add('togglepvp', Lang:t("comm.tglpvp"), {}, false, function()
    QBConfig.Server.PVP = not QBConfig.Server.PVP
    TriggerClientEvent('QBCore:Client:PvpHasToggled', -1, QBConfig.Server.PVP)
end, 'admin')

-- Permissions

QBCore.Commands.Add('addpermission', Lang:t("comm.addper"), { { name = Lang:t("comm.addper_id"), help = Lang:t("comm.addper_idh") }, { name = Lang:t("comm.addper_per"), help = Lang:t("comm.addper_perh") } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local permission = tostring(args[2]):lower()
    if Player then
        QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'god')

QBCore.Commands.Add('removepermission', Lang:t("comm.rper"), { { name = Lang:t("comm.rper_id"), help = Lang:t("comm.rper_idh") }, { name = Lang:t("comm.rper_per"), help = Lang:t("comm.rper_perh") } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local permission = tostring(args[2]):lower()
    if Player then
        QBCore.Functions.RemovePermission(Player.PlayerData.source, permission)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'god')

-- Open & Close Server

QBCore.Commands.Add('openserver', Lang:t("comm.opserv"), {}, false, function(source)
    if not QBCore.Config.Server.Closed then
        TriggerClientEvent('QBCore:Notify', source, Lang:t("notify.ops_open"), 'error')
        return
    end
    if QBCore.Functions.HasPermission(source, 'admin') then
        QBCore.Config.Server.Closed = false
    else
        QBCore.Functions.Kick(source, Lang:t("error.noperm"), nil, nil)
    end
end, 'admin')

QBCore.Commands.Add('closeserver', Lang:t("comm.cserv"), {{ name = Lang:t("comm.cserv_r"), help = Lang:t("comm.cserv_rh")}}, false, function(source, args)
    if QBCore.Config.Server.Closed then
        TriggerClientEvent('QBCore:Notify', source, Lang:t("notify.ops_closed"), 'error')
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
        QBCore.Functions.Kick(source, Lang:t("error.noperm"), nil, nil)
    end
end, 'admin')

-- Vehicle

QBCore.Commands.Add('car', Lang:t("comm.car"), {{ name = Lang:t("comm.car_m"), help = Lang:t("comm.car_mh") }}, true, function(source, args)
    TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])
end, 'admin')

QBCore.Commands.Add('dv', Lang:t("comm.dv"), {}, false, function(source)
    TriggerClientEvent('QBCore:Command:DeleteVehicle', source)
end, 'admin')

-- Money

QBCore.Commands.Add('givemoney', Lang:t("comm.gm"), { { name = Lang:t("comm.gm_id"), help = Lang:t("comm.gm_idh") }, { name = Lang:t("comm.gm_mt"), help = Lang:t("comm.gm_mth") }, { name = Lang:t("comm.gm_a"), help = Lang:t("comm.gm_ah") } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

QBCore.Commands.Add('setmoney', Lang:t("comm.sm"), { { name = Lang:t("comm.sm_id"), help = Lang:t("comm.sm_idh") }, { name = Lang:t("comm.sm_mt"), help = Lang:t("comm.sm_mth") }, { name = Lang:t("comm.sm_a"), help = Lang:t("comm.sm_ah") } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- Job

QBCore.Commands.Add('job', Lang:t("comm.job"), {}, false, function(source)
    local PlayerJob = QBCore.Functions.GetPlayer(source).PlayerData.job
    TriggerClientEvent('QBCore:Notify', source, Lang:t('info.job_info', {value = PlayerJob.label, value2 = PlayerJob.grade.name, value3 = PlayerJob.onduty}))
end, 'user')

QBCore.Commands.Add('setjob', Lang:t("comm.sjob"), { { name = Lang:t("comm.sjob_id"), help = Lang:t("comm.sjob_idh") }, { name = Lang:t("comm.sjob_j"), help = Lang:t("comm.sjob_jh") }, { name = Lang:t("comm.sjob_g"), help = Lang:t("comm.sjob_gh") } }, true, function(source, args)
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

QBCore.Commands.Add('setgang', Lang:t("comm.sg"), { { name = Lang:t("comm.sg_id"), help = Lang:t("comm.sg_idh") }, { name = Lang:t("comm.sg_g"), help = Lang:t("comm.sg_gh") }, { name = Lang:t("comm.sg_gr"), help = Lang:t("comm.sg_grh") } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetGang(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- Inventory (should be in qb-inventory?)

QBCore.Commands.Add('clearinv', Lang:t("comm.cinv"), { { name = Lang:t("comm.cinv_id"), help = Lang:t("comm.cinv_idh") } }, false, function(source, args)
    local playerId = args[1] ~= '' and args[1] or source
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
    for _, v in pairs(Players) do
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

QBCore.Commands.Add('me', Lang:t("comm.me"), {{name = Lang:t("comm.me_m"), help = Lang:t("comm.me_mh")}}, false, function(source, args)
    if #args < 1 then TriggerClientEvent('QBCore:Notify', source, Lang:t('error.missing_args2'), 'error') return end
    local ped = GetPlayerPed(source)
    local pCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local Players = QBCore.Functions.GetPlayers()
    for i=1, #Players do
        local Player = Players[i]
        local target = GetPlayerPed(Player)
        local tCoords = GetEntityCoords(target)
        if target == ped or #(pCoords - tCoords) < 20 then
            TriggerClientEvent('QBCore:Command:ShowMe3D', Player, source, msg)
        end
    end
end, 'user')

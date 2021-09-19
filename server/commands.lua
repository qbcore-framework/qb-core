function QBCore.Commands.Add(name, help, arguments, argsrequired, callback, permission)
  QBCore.Commands.List[name:lower()] = {
    name = name:lower(),
    permission = permission:lower() or 'user',
    help = help,
    arguments = arguments,
    argsrequired = argsrequired,
    callback = callback
  }
end

function QBCore.Commands.Refresh(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(tonumber(src))
  if Player then
    for command, info in pairs(QBCore.Commands.List) do
      if QBCore.Functions.HasPermission(src, 'god') or QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission) then
        TriggerClientEvent('chat:addSuggestion', src, '/' .. command, info.help, info.arguments)
      end
    end
  end
end

QBCore.Commands.Add(
  'tp',
  'TP To Player or Coords (Admin Only)',
  {{name = 'id/x', help = 'ID of player or X position'}, {name = 'y', help = 'Y position'}, {name = 'z', help = 'Z position'}},
  false,
  function(source, args)
    local src = source
    if (args[1] and (args[2] == nil and args[3] == nil)) then
      local player = GetPlayerPed(src)
      local target = GetPlayerPed(tonumber(args[1]))
      if target ~= 0 then
        local coords = GetEntityCoords(target)
        TriggerClientEvent('QBCore:Command:TeleportToPlayer', src, coords)
      else
        TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
      end
    else
      if args[1] and args[2] and args[3] then
        local player = GetPlayerPed(src)
        local x = tonumber(args[1])
        local y = tonumber(args[2])
        local z = tonumber(args[3])
        if x and y and z then
          TriggerClientEvent('QBCore:Command:TeleportToCoords', src, x, y, z)
        else
          TriggerClientEvent('QBCore:Notify', src, 'Incorrect Format', 'error')
        end
      else
        TriggerClientEvent('QBCore:Notify', src, 'Not every argument has been entered (x, y, z)', 'error')
      end
    end
  end,
  'admin'
)

QBCore.Commands.Add(
  'addpermission',
  'Give Player Permissions (God Only)',
  {{name = 'id', help = 'ID of player'}, {name = 'permission', help = 'Permission level'}},
  true,
  function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local permission = tostring(args[2]):lower()
    if player then
      QBCore.Functions.AddPermission(player.PlayerData.source, permission)
    else
      TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
    end
  end,
  'god'
)

QBCore.Commands.Add(
  'removepermission',
  'Remove Players Permissions (God Only)',
  {{name = 'id', help = 'ID of player'}},
  true,
  function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if player then
      QBCore.Functions.RemovePermission(player.PlayerData.source)
    else
      TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
    end
  end,
  'god'
)

QBCore.Commands.Add(
  'car',
  'Spawn Vehicle (Admin Only)',
  {{name = 'model', help = 'Model name of the vehicle'}},
  true,
  function(source, args)
    local src = source
    if args[1] then
      TriggerClientEvent('QBCore:Command:SpawnVehicle', src, args[1])
    else
      TriggerClientEvent('QBCore:Notify', src, 'No Vehicle Specified', 'error')
    end
  end,
  'admin'
)

QBCore.Commands.Add(
  'dv',
  'Delete Vehicle (Admin Only)',
  {},
  false,
  function(source)
    local src = source
    TriggerClientEvent('QBCore:Command:DeleteVehicle', src)
  end,
  'admin'
)

QBCore.Commands.Add(
  'tpm',
  'TP To Marker (Admin Only)',
  {},
  false,
  function(source)
    local src = source
    TriggerClientEvent('QBCore:Command:GoToMarker', src)
  end,
  'admin'
)

QBCore.Commands.Add(
  'givemoney',
  'Give A Player Money (Admin Only)',
  {{name = 'id', help = 'Player ID'}, {name = 'moneytype', help = 'Type of money (cash, bank, crypto)'}, {name = 'amount', help = 'Amount of money'}},
  true,
  function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if player then
      player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
    else
      TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
    end
  end,
  'admin'
)

QBCore.Commands.Add(
  'setmoney',
  'Set Players Money Amount (Admin Only)',
  {{name = 'id', help = 'Player ID'}, {name = 'moneytype', help = 'Type of money (cash, bank, crypto)'}, {name = 'amount', help = 'Amount of money'}},
  true,
  function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if player then
      player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
    else
      TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
    end
  end,
  'admin'
)

QBCore.Commands.Add(
  'setjob',
  'Set A Players Job (Admin Only)',
  {{name = 'id', help = 'Player ID'}, {name = 'job', help = 'Job name'}, {name = 'grade', help = 'Grade'}},
  true,
  function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if player then
      player.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
    else
      TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
    end
  end,
  'admin'
)

QBCore.Commands.Add(
  'job',
  'Check Your Job',
  {},
  false,
  function(source)
    local src = source
    local playerJob = QBCore.Functions.GetPlayer(src).PlayerData.job
    TriggerClientEvent('QBCore:Notify', source, string.format('[Job]: %s [Grade]: %s [On Duty]: %s', playerJob.label, playerJob.grade.name, playerJob.onduty))
  end
)

QBCore.Commands.Add(
  'setgang',
  'Set A Players Gang (Admin Only)',
  {{name = 'id', help = 'Player ID'}, {name = 'gang', help = 'Name of a gang'}, {name = 'grade', help = 'Grade'}},
  true,
  function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if player then
      Player.Functions.SetGang(tostring(args[2]), tonumber(args[3]))
    else
      TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
    end
  end,
  'admin'
)

QBCore.Commands.Add(
  'gang',
  'Check Your Gang',
  {},
  false,
  function(source)
    local src = source
    local playerGang = QBCore.Functions.GetPlayer(src).PlayerData.gang
    TriggerClientEvent('QBCore:Notify', src, string.format('[Gang]: %s [Grade]: %s', playerGang.label, playerGang.grade.name))
  end
)

QBCore.Commands.Add(
  'clearinv',
  'Clear Players Inventory (Admin Only)',
  {{name = 'id', help = 'Player ID'}},
  false,
  function(source, args)
    local src = source
    local playerId = args[1] or src
    local player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if player then
      player.Functions.ClearInventory()
    else
      TriggerClientEvent('QBCore:Notify', src, 'Player Not Online', 'error')
    end
  end,
  'admin'
)

-- QBCore.Commands.Add("ooc", "OOC Chat Message", {}, false, function(source, args)
-- 	local message = table.concat(args, " ")
-- 	local Players = QBCore.Functions.GetPlayers()
-- 	local Player = QBCore.Functions.GetPlayer(source)

-- 	for k, v in pairs(QBCore.Functions.GetPlayers()) do
-- 		if v == source then
-- 			TriggerClientEvent('chatMessage', v, "OOC " .. GetPlayerName(source), "normal", message)
-- 		elseif #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
-- 			TriggerClientEvent('chatMessage', v, "OOC " .. GetPlayerName(source), "normal", message)
-- 		elseif QBCore.Functions.HasPermission(v, "admin") then
-- 			if QBCore.Functions.IsOptin(v) then
-- 				TriggerClientEvent('chatMessage', v, "Proximity OOC " .. GetPlayerName(source), "normal", message)
-- 				TriggerEvent("qb-log:server:CreateLog", "ooc", "OOC", "white", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Message:** " ..message, false)
-- 			end
-- 		end
-- 	end
-- end)

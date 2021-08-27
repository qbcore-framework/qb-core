QBCore.Commands = {}
QBCore.Commands.List = {}

QBCore.Commands.Add = function(name, help, arguments, argsrequired, callback, permission) -- [name] = command name (ex. /givemoney), [help] = help text, [arguments] = arguments that need to be passed (ex. {{name="id", help="ID of a player"}, {name="amount", help="amount of money"}}), [argsrequired] = set arguments required (true or false), [callback] = function(source, args) callback, [permission] = rank or job of a player
	QBCore.Commands.List[name:lower()] = {
		name = name:lower(),
		permission = permission ~= nil and permission:lower() or "user",
		help = help,
		arguments = arguments,
		argsrequired = argsrequired,
		callback = callback,
	}
end

QBCore.Commands.Refresh = function(source)
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
	if Player ~= nil then
		for command, info in pairs(QBCore.Commands.List) do
			if QBCore.Functions.HasPermission(source, "god") or QBCore.Functions.HasPermission(source, QBCore.Commands.List[command].permission) then
				TriggerClientEvent('chat:addSuggestion', source, "/"..command, info.help, info.arguments)
			end
		end
	end
end

QBCore.Commands.Add("tp", "TP To Player or Coords (Admin Only)", {{name="id/x", help="ID of player or X position"}, {name="y", help="Y position"}, {name="z", help="Z position"}}, false, function(source, args)
	if (args[1] ~= nil and (args[2] == nil and args[3] == nil)) then
		local player = GetPlayerPed(source)
		local target = GetPlayerPed(tonumber(args[1]))
		if target ~= 0 then
			local coords = GetEntityCoords(target)
			TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
		else
			TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
		end
	else
		if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
			local player = GetPlayerPed(source)
			local x = tonumber(args[1])
			local y = tonumber(args[2])
			local z = tonumber(args[3])
			if (x ~= 0) and (y ~= 0) and (z ~= 0) then
				TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
			else
				TriggerClientEvent('QBCore:Notify', source, "Incorrect Format", "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', source, "Not every argument has been entered (x, y, z)", "error")
		end
	end
end, "admin")

QBCore.Commands.Add("addpermission", "Give Player Permissions (God Only)", {{name="id", help="ID of player"}, {name="permission", help="Permission level"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local permission = tostring(args[2]):lower()
	if Player ~= nil then
		QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")	
	end		
end, "god")

QBCore.Commands.Add("removepermission", "Remove Players Permissions (God Only)", {{name="id", help="ID of player"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		QBCore.Functions.RemovePermission(Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")	
	end
end, "god")

QBCore.Commands.Add("car", "Spawn Vehicle (Admin Only)", {{name="model", help="Model name of the vehicle"}}, true, function(source, args)
	TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])	
end, "admin")

QBCore.Commands.Add("dv", "Delete Vehicle (Admin Only)", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:DeleteVehicle', source)
end, "admin")

QBCore.Commands.Add("tpm", "TP To Marker (Admin Only)", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:GoToMarker', source)
end, "admin")

QBCore.Commands.Add("givemoney", "Give A Player Money (Admin Only)", {{name="id", help="Player ID"},{name="moneytype", help="Type of money (cash, bank, crypto)"}, {name="amount", help="Amount of money"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")

QBCore.Commands.Add("setmoney", "Set Players Money Amount (Admin Only)", {{name="id", help="Player ID"},{name="moneytype", help="Type of money (cash, bank, crypto)"}, {name="amount", help="Amount of money"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")

QBCore.Commands.Add("setjob", "Set A Players Job (Admin Only)", {{name="id", help="Player ID"}, {name="job", help="Job name"}, {name="grade", help="Grade"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player == nil then
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	else
		Player.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
	end
end, "admin")

QBCore.Commands.Add("job", "Check Your Job", {}, false, function(source, args)
	local PlayerJob = QBCore.Functions.GetPlayer(source).PlayerData.job
	TriggerClientEvent('QBCore:Notify', source, string.format("[Job]: %s [Grade]: %s [On Duty]: %s", PlayerJob.label, PlayerJob.grade.name, PlayerJob.onduty))
end)

QBCore.Commands.Add("setgang", "Set A Players Gang (Admin Only)", {{name="id", help="Player ID"}, {name="gang", help="Name of a gang"}, {name="grade", help="Grade"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player == nil then
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	else
		Player.Functions.SetGang(tostring(args[2]), tonumber(args[3]))
	end
end, "admin")

QBCore.Commands.Add("gang", "Check Your Gang", {}, false, function(source, args)
	local PlayerGang = QBCore.Functions.GetPlayer(source).PlayerData.gang
	TriggerClientEvent('QBCore:Notify', source, string.format("[Gang]: %s [Grade]: %s", PlayerGang.label, PlayerGang.grade.name))
end)

QBCore.Commands.Add("clearinv", "Clear Players Inventory (Admin Only)", {{name="id", help="Player ID"}}, false, function(source, args)
	local playerId = args[1] ~= nil and args[1] or source
	local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
	if Player ~= nil then
		Player.Functions.ClearInventory()
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")

QBCore.Commands.Add("ooc", "OOC Chat Message", {}, false, function(source, args)
	local message = table.concat(args, " ")
	local Players = QBCore.Functions.GetPlayers()
	local Player = QBCore.Functions.GetPlayer(source)

	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		if v == source then
			TriggerClientEvent('chatMessage', v, "OOC " .. GetPlayerName(source), "normal", message)
		elseif #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
			TriggerClientEvent('chatMessage', v, "OOC " .. GetPlayerName(source), "normal", message)
		elseif QBCore.Functions.HasPermission(v, "admin") then
			if QBCore.Functions.IsOptin(v) then
				TriggerClientEvent('chatMessage', v, "Proximity OOC " .. GetPlayerName(source), "normal", message)
				TriggerEvent("qb-log:server:CreateLog", "ooc", "OOC", "white", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Message:** " ..message, false)
			end
		end
	end
end)

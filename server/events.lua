-- Player joined
RegisterServerEvent("QBCore:PlayerJoined")
AddEventHandler('QBCore:PlayerJoined', function()
	local src = source
end)

AddEventHandler('playerDropped', function(reason) 
	local src = source
	print("Dropped: "..GetPlayerName(src))
	TriggerEvent("qb-log:server:CreateLog", "joinleave", "Dropped", "red", "**".. GetPlayerName(src) .. "** ("..GetPlayerIdentifiers(src)[1]..") left..")
	if reason ~= "Reconnecting" and src > 60000 then return false end
	if(src==nil or (QBCore.Players[src] == nil)) then return false end
	QBCore.Players[src].Functions.Save()
	QBCore.Players[src] = nil
end)

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()

    -- mandatory wait!
    Wait(0)

    deferrals.update(string.format("Hello %s. Your Steam ID is being checked.", name))

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    -- mandatory wait!
    Wait(2500)

    deferrals.update(string.format("Hello %s. We are checking if you are banned.", name))
	
    local isBanned, Reason = QBCore.Functions.IsPlayerBanned(player)
	
    Wait(2500)
	
    deferrals.update(string.format("Welcome %s to {Server Name}.", name))

    if not steamIdentifier then
        deferrals.done("You are not connected to Steam.")
    elseif isBanned then
	deferrals.done(Reason)
    else
        deferrals.done()
	Wait(1000)
	TriggerEvent("connectqueue:playerConnect", name, setKickReason, deferrals)
    end
    --Add any additional defferals you may need!
    
end

AddEventHandler("playerConnecting", OnPlayerConnecting)


RegisterServerEvent("QBCore:server:CloseServer")
AddEventHandler('QBCore:server:CloseServer', function(reason)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if QBCore.Functions.HasPermission(source, "admin") or QBCore.Functions.HasPermission(source, "god") then 
        local reason = reason ~= nil and reason or "No reason specified..."
        QBCore.Config.Server.closed = true
        QBCore.Config.Server.closedReason = reason
        TriggerClientEvent("qbadmin:client:SetServerStatus", -1, true)
	else
		QBCore.Functions.Kick(src, "You don't have permissions for this..", nil, nil)
    end
end)

RegisterServerEvent("QBCore:server:OpenServer")
AddEventHandler('QBCore:server:OpenServer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if QBCore.Functions.HasPermission(source, "admin") or QBCore.Functions.HasPermission(source, "god") then
        QBCore.Config.Server.closed = false
        TriggerClientEvent("qbadmin:client:SetServerStatus", -1, false)
    else
        QBCore.Functions.Kick(src, "You don't have permissions for this..", nil, nil)
    end
end)

RegisterServerEvent("QBCore:UpdatePlayer")
AddEventHandler('QBCore:UpdatePlayer', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
	if Player ~= nil then
		Player.PlayerData.position = data.position

		local newHunger = Player.PlayerData.metadata["hunger"] - 4.2
		local newThirst = Player.PlayerData.metadata["thirst"] - 3.8
		if newHunger <= 0 then newHunger = 0 end
		if newThirst <= 0 then newThirst = 0 end
		Player.Functions.SetMetaData("thirst", newThirst)
		Player.Functions.SetMetaData("hunger", newHunger)

		Player.Functions.AddMoney("bank", Player.PlayerData.job.payment)
		TriggerClientEvent('QBCore:Notify', src, "You received your paycheck of $"..Player.PlayerData.job.payment)
		TriggerClientEvent("hud:client:UpdateNeeds", src, newHunger, newThirst)

		Player.Functions.Save()
	end
end)

RegisterServerEvent("QBCore:UpdatePlayerPosition")
AddEventHandler("QBCore:UpdatePlayerPosition", function(position)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.PlayerData.position = position
	end
end)

RegisterServerEvent("QBCore:Server:TriggerCallback")
AddEventHandler('QBCore:Server:TriggerCallback', function(name, ...)
	local src = source
	QBCore.Functions.TriggerCallback(name, src, function(...)
		TriggerClientEvent("QBCore:Client:TriggerCallback", src, name, ...)
	end, ...)
end)

RegisterServerEvent("QBCore:Server:UseItem")
AddEventHandler('QBCore:Server:UseItem', function(item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if item ~= nil and item.amount > 0 then
		if QBCore.Functions.CanUseItem(item.name) then
			QBCore.Functions.UseItem(src, item)
		end
	end
end)

RegisterServerEvent("QBCore:Server:RemoveItem")
AddEventHandler('QBCore:Server:RemoveItem', function(itemName, amount, slot)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(itemName, amount, slot)
end)

RegisterServerEvent("QBCore:Server:AddItem")
AddEventHandler('QBCore:Server:AddItem', function(itemName, amount, slot, info)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(itemName, amount, slot, info)
end)

RegisterServerEvent('QBCore:Server:SetMetaData')
AddEventHandler('QBCore:Server:SetMetaData', function(meta, data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if meta == "hunger" or meta == "thirst" then
		if data > 100 then
			data = 100
		end
	end
	if Player ~= nil then 
		Player.Functions.SetMetaData(meta, data)
	end
	TriggerClientEvent("hud:client:UpdateNeeds", src, Player.PlayerData.metadata["hunger"], Player.PlayerData.metadata["thirst"])
end)

AddEventHandler('chatMessage', function(source, n, message)
	if string.sub(message, 1, 1) == "/" then
		local args = QBCore.Shared.SplitStr(message, " ")
		local command = string.gsub(args[1]:lower(), "/", "")
		CancelEvent()
		if QBCore.Commands.List[command] ~= nil then
			local Player = QBCore.Functions.GetPlayer(tonumber(source))
			if Player ~= nil then
				table.remove(args, 1)
				if (QBCore.Functions.HasPermission(source, "god") or QBCore.Functions.HasPermission(source, QBCore.Commands.List[command].permission)) then
					if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
					    TriggerClientEvent('QBCore:Notify', source, "All arguments must be filled out!", "error")
					    local agus = ""
					    for name, help in pairs(QBCore.Commands.List[command].arguments) do
					    	agus = agus .. " ["..help.name.."]"
					    end
				        TriggerClientEvent('chatMessage', source, "/"..command, false, agus)
					else
						QBCore.Commands.List[command].callback(source, args)
					end
				else
					TriggerClientEvent('QBCore:Notify', source, "No Access To This Command", "error")
				end
			end
		end
	end
end)

RegisterServerEvent('QBCore:CallCommand')
AddEventHandler('QBCore:CallCommand', function(command, args)
	if QBCore.Commands.List[command] ~= nil then
		local Player = QBCore.Functions.GetPlayer(tonumber(source))
		if Player ~= nil then
			if (QBCore.Functions.HasPermission(source, "god")) or (QBCore.Functions.HasPermission(source, QBCore.Commands.List[command].permission)) or (QBCore.Commands.List[command].permission == Player.PlayerData.job.name) then
				if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
					TriggerClientEvent('QBCore:Notify', source, "All arguments must be filled out!", "error")
					local agus = ""
					for name, help in pairs(QBCore.Commands.List[command].arguments) do
						agus = agus .. " ["..help.name.."]"
					end
					TriggerClientEvent('chatMessage', source, "/"..command, false, agus)
				else
					QBCore.Commands.List[command].callback(source, args)
				end
			else
				TriggerClientEvent('QBCore:Notify', source, "No Access To This Command", "error")
			end
		end
	end
end)

RegisterServerEvent("QBCore:AddCommand")
AddEventHandler('QBCore:AddCommand', function(name, help, arguments, argsrequired, callback, persmission)
	QBCore.Commands.Add(name, help, arguments, argsrequired, callback, persmission)
end)

RegisterServerEvent("QBCore:ToggleDuty")
AddEventHandler('QBCore:ToggleDuty', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.onduty then
		Player.Functions.SetJobDuty(false)
		TriggerClientEvent('QBCore:Notify', src, "You are now off duty!")
	else
		Player.Functions.SetJobDuty(true)
		TriggerClientEvent('QBCore:Notify', src, "You are now on duty!")
	end
	TriggerClientEvent("QBCore:Client:SetDuty", src, Player.PlayerData.job.onduty)
end)

Citizen.CreateThread(function()
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `permissions`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				QBCore.Config.Server.PermissionList[v.steam] = {
					steam = v.steam,
					license = v.license,
					permission = v.permission,
					optin = true,
				}
			end
		end
	end)
end)

QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, itemName)
	local retval = false
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	
	cb(retval)
end)	

RegisterServerEvent('QBCore:Command:CheckOwnedVehicle')
AddEventHandler('QBCore:Command:CheckOwnedVehicle', function(VehiclePlate)
	if VehiclePlate ~= nil then
		QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..VehiclePlate.."'", function(result)
			if result[1] ~= nil then
				QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `state` = '1' WHERE `citizenid` = '"..result[1].citizenid.."'")
				TriggerEvent('qb-garages:server:RemoveVehicle', result[1].citizenid, VehiclePlate)
			end
		end)
	end
end)

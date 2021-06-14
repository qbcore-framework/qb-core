QBCore.Functions = {}

QBCore.Functions.ExecuteSql = function(wait, params, query, cb)
	local rtndata = {}
	local waiting = true

	-- Really bad hack for backwards compatibility
	if type(params) == 'string' then
		cb = query
		query = params
		params = {}
	end

	if params == nil then 
		params = {} 
	end
	
	exports['ghmattimysql']:execute(query, params, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
	end
	return rtndata
end

QBCore.Functions.GetIdentifier = function(source, idtype)
	local idtype = idtype ~=nil and idtype or QBConfig.IdentifierType
	for _, identifier in pairs(GetPlayerIdentifiers(source)) do
		if string.find(identifier, idtype) then
			return identifier
		end
	end
	return nil
end

QBCore.Functions.GetSource = function(identifier)
	for src, player in pairs(QBCore.Players) do
		local idens = GetPlayerIdentifiers(src)
		for _, id in pairs(idens) do
			if identifier == id then
				return src
			end
		end
	end
	return 0
end

QBCore.Functions.GetPlayer = function(source)
	if type(source) == "number" then
		return QBCore.Players[source]
	else
		return QBCore.Players[QBCore.Functions.GetSource(source)]
	end
end

QBCore.Functions.GetPlayerByCitizenId = function(citizenid)
	for src, player in pairs(QBCore.Players) do
		local cid = citizenid
		if QBCore.Players[src].PlayerData.citizenid == cid then
			return QBCore.Players[src]
		end
	end
	return nil
end

QBCore.Functions.GetPlayerByPhone = function(number)
	for src, player in pairs(QBCore.Players) do
		local cid = citizenid
		if QBCore.Players[src].PlayerData.charinfo.phone == number then
			return QBCore.Players[src]
		end
	end
	return nil
end

QBCore.Functions.GetPlayers = function()
	local sources = {}
	for k, v in pairs(QBCore.Players) do
		table.insert(sources, k)
	end
	return sources
end

QBCore.Functions.CreateCallback = function(name, cb)
	QBCore.ServerCallbacks[name] = cb
end

QBCore.Functions.TriggerCallback = function(name, source, cb, ...)
	if QBCore.ServerCallbacks[name] ~= nil then
		QBCore.ServerCallbacks[name](source, cb, ...)
	end
end

QBCore.Functions.CreateUseableItem = function(item, cb)
	QBCore.UseableItems[item] = cb
end

QBCore.Functions.CanUseItem = function(item)
	return QBCore.UseableItems[item] ~= nil
end

QBCore.Functions.UseItem = function(source, item)
	QBCore.UseableItems[item.name](source, item)
end

QBCore.Functions.Kick = function(source, reason, setKickReason, deferrals)
	local src = source
	reason = "\n"..reason.."\n🔸 Check our Discord for further information: "..QBCore.Config.Server.discord
	if(setKickReason ~=nil) then
		setKickReason(reason)
	end
	Citizen.CreateThread(function()
		if(deferrals ~= nil)then
			deferrals.update(reason)
			Citizen.Wait(2500)
		end
		if src ~= nil then
			DropPlayer(src, reason)
		end
		local i = 0
		while (i <= 4) do
			i = i + 1
			while true do
				if src ~= nil then
					if(GetPlayerPing(src) >= 0) then
						break
					end
					Citizen.Wait(100)
					Citizen.CreateThread(function() 
						DropPlayer(src, reason)
					end)
				end
			end
			Citizen.Wait(5000)
		end
	end)
end

QBCore.Functions.IsWhitelisted = function(source)
	local identifiers = GetPlayerIdentifiers(source)
	local rtn = false
	if (QBCore.Config.Server.whitelist) then
		QBCore.Functions.ExecuteSql(true, {['a'] = QBCore.Config.IdentifierType, ['b'] = QBCore.Functions.GetIdentifier(source)}, "SELECT * FROM `whitelist` WHERE `@a` = @b", function(result)
			local data = result[1]
			if data ~= nil then
				for _, id in pairs(identifiers) do
					if data.steam == id or data.license == id then
						rtn = true
					end
				end
			end
		end)
	else
		rtn = true
	end
	return rtn
end

QBCore.Functions.AddPermission = function(source, permission)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		QBCore.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = {
			steam = GetPlayerIdentifiers(source)[1],
			license = GetPlayerIdentifiers(source)[2],
			permission = permission:lower(),
		}
		QBCore.Functions.ExecuteSql(true, {['a']=GetPlayerIdentifiers(source)[1]}, "DELETE FROM `permissions` WHERE `steam` = @a")
		QBCore.Functions.ExecuteSql(
			true,
			{
				['a'] = GetPlayerName(source),
				['b'] = GetPlayerIdentifiers(source)[1],
				['c'] = GetPlayerIdentifiers(source)[2],
				['d'] = permission:lower()
			},
			"INSERT INTO `permissions` (`name`, `steam`, `license`, `permission`) VALUES (@a, @b, @c, @d)")
		Player.Functions.UpdatePlayerData()
		TriggerClientEvent('QBCore:Client:OnPermissionUpdate', source, permission)
	end
end

QBCore.Functions.RemovePermission = function(source)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		QBCore.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = nil	
		QBCore.Functions.ExecuteSql(true, {['a'] = GetPlayerIdentifiers(source)[1]}, "DELETE FROM `permissions` WHERE `steam` = @a")
		Player.Functions.UpdatePlayerData()
	end
end

QBCore.Functions.HasPermission = function(source, permission)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	local permission = tostring(permission:lower())
	if permission == "user" then
		retval = true
	else
		if QBCore.Config.Server.PermissionList[steamid] ~= nil then 
			if QBCore.Config.Server.PermissionList[steamid].steam == steamid and QBCore.Config.Server.PermissionList[steamid].license == licenseid then
				if QBCore.Config.Server.PermissionList[steamid].permission == permission or QBCore.Config.Server.PermissionList[steamid].permission == "god" then
					retval = true
				end
			end
		end
	end
	return retval
end

QBCore.Functions.GetPermission = function(source)
	local retval = "user"
	Player = QBCore.Functions.GetPlayer(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	if Player ~= nil then
		if QBCore.Config.Server.PermissionList[Player.PlayerData.steam] ~= nil then 
			if QBCore.Config.Server.PermissionList[Player.PlayerData.steam].steam == steamid and QBCore.Config.Server.PermissionList[Player.PlayerData.steam].license == licenseid then
				retval = QBCore.Config.Server.PermissionList[Player.PlayerData.steam].permission
			end
		end
	end
	return retval
end

QBCore.Functions.IsOptin = function(source)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	if QBCore.Functions.HasPermission(source, "admin") then
		retval = QBCore.Config.Server.PermissionList[steamid].optin
	end
	return retval
end

QBCore.Functions.ToggleOptin = function(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	if QBCore.Functions.HasPermission(source, "admin") then
		QBCore.Config.Server.PermissionList[steamid].optin = not QBCore.Config.Server.PermissionList[steamid].optin
	end
end

QBCore.Functions.IsPlayerBanned = function (source)
	local retval = false
	local message = ""
	QBCore.Functions.ExecuteSql(
		true, 
		{
			['a'] = GetPlayerIdentifiers(source)[1],
			['b'] = GetPlayerIdentifiers(source)[2],
			['c'] = GetPlayerIdentifiers(source)[3]
		}, 
		"SELECT * FROM `bans` WHERE `steam` = @a OR `license` = @b OR `ip` = @c", function(result)
		if result[1] ~= nil then 
			if os.time() < result[1].expire then
				retval = true
				local timeTable = os.date("*t", tonumber(result[1].expire))
				message = "You have been banned from the server:\n"..result[1].reason.."\nJe ban verloopt "..timeTable.day.. "/" .. timeTable.month .. "/" .. timeTable.year .. " " .. timeTable.hour.. ":" .. timeTable.min .. "\n"
			else
				QBCore.Functions.ExecuteSql(true, {['a'] = result[1].id}, "DELETE FROM `bans` WHERE `id` = @a")
			end
		end
	end)
	return retval, message
end


QBCore.Functions = {}

QBCore.Functions.ExecuteSql = function(wait, query, cb)
	local rtndata = {}
	local waiting = true
	exports['ghmattimysql']:execute(query, {}, function(data)
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

QBCore.Functions.GetEntityCoords = function(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        a = heading
    }
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
		exports['ghmattimysql']:execute('SELECT * FROM whitelist WHERE license=@license', {['@license'] = QBCore.Functions.GetIdentifier(source, 'license')}, function(result)
			local data = result[1]
			if data ~= nil then
				for _, id in pairs(identifiers) do
					if data.license == id then
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
		QBCore.Config.Server.PermissionList[QBCore.Functions.GetIdentifier(source, 'license')] = {
			license = QBCore.Functions.GetIdentifier(source, 'license'),
			permission = permission:lower(),
		}
		exports['ghmattimysql']:execute('DELETE FROM permissions WHERE license=@license', {['@license'] = QBCore.Functions.GetIdentifier(source, 'license')})

		exports['ghmattimysql']:execute('INSERT INTO permissions (name, license, permission) VALUES (@name, @license, @permission)', {
			['@name'] = GetPlayerName(source),
			['@license'] = QBCore.Functions.GetIdentifier(source, 'license'),
			['@permission'] = permission:lower()
		})

		Player.Functions.UpdatePlayerData()
		TriggerClientEvent('QBCore:Client:OnPermissionUpdate', source, permission)
	end
end

QBCore.Functions.RemovePermission = function(source)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		QBCore.Config.Server.PermissionList[QBCore.Functions.GetIdentifier(source, 'license')] = nil	
		exports['ghmattimysql']:execute('DELETE FROM permissions WHERE license=@license', {['@license'] = QBCore.Functions.GetIdentifier(source, 'license')})
		Player.Functions.UpdatePlayerData()
	end
end

QBCore.Functions.HasPermission = function(source, permission)
	local retval = false
	local license = QBCore.Functions.GetIdentifier(source, 'license')
	local permission = tostring(permission:lower())
	if permission == "user" then
		retval = true
	else
		if QBCore.Config.Server.PermissionList[license] ~= nil then 
			if QBCore.Config.Server.PermissionList[license].license == license then
				if QBCore.Config.Server.PermissionList[license].permission == permission or QBCore.Config.Server.PermissionList[license].permission == "god" then
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
	local license = QBCore.Functions.GetIdentifier(source, 'license')
	if Player ~= nil then
		if QBCore.Config.Server.PermissionList[Player.PlayerData.license] ~= nil then 
			if QBCore.Config.Server.PermissionList[Player.PlayerData.license].license == license then
				retval = QBCore.Config.Server.PermissionList[Player.PlayerData.license].permission
			end
		end
	end
	return retval
end

QBCore.Functions.IsOptin = function(source)
	local retval = false
	local license = QBCore.Functions.GetIdentifier(source, 'license')
	if QBCore.Functions.HasPermission(source, "admin") then
		retval = QBCore.Config.Server.PermissionList[license].optin
	end
	return retval
end

QBCore.Functions.ToggleOptin = function(source)
	local license = QBCore.Functions.GetIdentifier(source, 'license')
	if QBCore.Functions.HasPermission(source, "admin") then
		QBCore.Config.Server.PermissionList[license].optin = not QBCore.Config.Server.PermissionList[license].optin
	end
end

QBCore.Functions.IsPlayerBanned = function (source)
	local retval = false
	local message = ""
	exports['ghmattimysql']:execute('SELECT * FROM bans WHERE license=@license', {['@license'] = QBCore.Functions.GetIdentifier(source, 'license')}, function(result)
		if result[1] ~= nil then 
			if os.time() < result[1].expire then
				retval = true
				local timeTable = os.date("*t", tonumber(result[1].expire))
				message = "You have been banned from the server:\n"..result[1].reason.."\nYour ban expires "..timeTable.day.. "/" .. timeTable.month .. "/" .. timeTable.year .. " " .. timeTable.hour.. ":" .. timeTable.min .. "\n"
			else
				exports['ghmattimysql']:execute('DELETE FROM bans WHERE id=@id', {['@id'] = result[1].id})
			end
		end
	end)
	return retval, message
end
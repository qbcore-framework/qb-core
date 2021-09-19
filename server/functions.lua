function GetCoreObject()
  return QBCore
end

function PaycheckInterval()
  local Players = QBCore.Functions.GetPlayers()
  for i = 1, #Players, 1 do
    local Player = QBCore.Functions.GetPlayer(Players[i])
    if Player.PlayerData.job?[payment] > 0 then
      Player.Functions.AddMoney('bank', Player.PlayerData.job.payment)
      TriggerClientEvent('QBCore:Notify', Players[i], 'You received your paycheck of $' .. Player.PlayerData.job.payment)
    end
  end
  SetTimeout(QBCore.Config.Money.PaycheckInterval * (60 * 1000), PaycheckInterval)
end

function QBCore.Functions.GetIdentifier(source, idtype)
  local src = source
  local idtype = idtype or QBConfig.IdentifierType
  for _, identifier in pairs(GetPlayerIdentifiers(src)) do
    if string.find(identifier, idtype) then
      return identifier
    end
  end
  return nil
end

function QBCore.Functions.GetSource(identifier)
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

function QBCore.Functions.GetPlayer(source)
  local src = source
  if type(src) == 'number' then
    return QBCore.Players[src]
  else
    return QBCore.Players[QBCore.Functions.GetSource(src)]
  end
end

function QBCore.Functions.GetPlayerByCitizenId(citizenid)
  for src, player in pairs(QBCore.Players) do
    if QBCore.Players[src].PlayerData.citizenid == citizenid then
      return QBCore.Players[src]
    end
  end
  return nil
end

function QBCore.Functions.GetPlayerByPhone(number)
  for src, player in pairs(QBCore.Players) do
    if QBCore.Players[src].PlayerData.charinfo.phone == number then
      return QBCore.Players[src]
    end
  end
  return nil
end

function QBCore.Functions.GetPlayers()
  local sources = {}
  for k, v in pairs(QBCore.Players) do
    table.insert(sources, k)
  end
  return sources
end

function QBCore.Functions.CreateCallback(name, cb)
  QBCore.ServerCallbacks[name] = cb
end

function QBCore.Functions.TriggerCallback(name, source, cb, ...)
  if QBCore.ServerCallbacks[name] ~= nil then
    QBCore.ServerCallbacks[name](source, cb, ...)
  end
end

function QBCore.Functions.CreateUseableItem(item, cb)
  QBCore.UseableItems[item] = cb
end

function QBCore.Functions.CanUseItem(item)
  return QBCore.UseableItems[item] ~= nil
end

function QBCore.Functions.UseItem(source, item)
  local src = source
  QBCore.UseableItems[item.name](src, item)
end

function QBCore.Functions.Kick(source, reason)
  local src = source
  local reason = reason or Config.KickMessage
  DropPlayer(src, reason)
end

function QBCore.Functions.AddPermission(source, permission)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if player then
    local plicense = player.PlayerData.license
    QBCore.Config.Server.PermissionList[plicense] = {
      license = plicense,
      permission = permission:lower()
    }
    exports.oxmysql:insert(
      'INSERT INTO permissions (name, license, permission) VALUES (name, license, permlevel) ON DUPLICATE KEY UPDATE license = :license',
      {
        name = GetPlayerName(src),
        license = plicense,
        permlevel = permission:lower()
      }
    )
    player.Functions.UpdatePlayerData()
    TriggerClientEvent('QBCore:Client:OnPermissionUpdate', src, permission)
  end
end

function QBCore.Functions.RemovePermission(source)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if player then
    local license = player.PlayerData.license
    QBCore.Config.Server.PermissionList[license] = nil
    exports.oxmysql:execute('DELETE FROM permissions WHERE license = ?', {license})
    player.Functions.UpdatePlayerData()
  end
end

function QBCore.Functions.HasPermission(source, permission)
  local src = source
  local license = QBCore.Functions.GetIdentifier(src, 'license')
  local permission = tostring(permission:lower())
  if permission ~= 'user' then
    if QBCore.Config.Server.PermissionList[license] then
      if QBCore.Config.Server.PermissionList[license].license == license then
        if QBCore.Config.Server.PermissionList[license].permission == permission then
          return true
        end
      end
    end
  else
    return true
  end
  return false
end

function QBCore.Functions.GetPermission(source)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  local license = player.PlayerData.license
  if player then
    if QBCore.Config.Server.PermissionList[Player.PlayerData.license] then
      if QBCore.Config.Server.PermissionList[Player.PlayerData.license].license == license then
        return QBCore.Config.Server.PermissionList[Player.PlayerData.license].permission
      end
    end
  end
  return 'user'
end

function QBCore.Functions.IsOptin(source)
  local src = source
  local license = QBCore.Functions.GetIdentifier(src, 'license')
  if QBCore.Functions.HasPermission(src, 'admin') then
    return QBCore.Config.Server.PermissionList[license].optin
  end
  return false
end

function QBCore.Functions.ToggleOptin(source)
  local src = source
  local license = QBCore.Functions.GetIdentifier(src, 'license')
  if QBCore.Functions.HasPermission(src, 'admin') then
    QBCore.Config.Server.PermissionList[license].optin = not QBCore.Config.Server.PermissionList[license].optin
  end
end

function QBCore.Functions.IsPlayerBanned(source)
  local src = source
  local message = ''
  local result = exports.oxmysql:singleSync('SELECT * FROM bans WHERE license = ?', {QBCore.Functions.GetIdentifier(src, 'license')})
  if result then
    if os.time() < result.expire then
      local timeTable = os.date('*t', tonumber(result.expire))
      message = 'You have been banned from the server:\n' .. result.reason .. '\nYour ban expires ' .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
    else
      exports.oxmysql:execute('DELETE FROM bans WHERE id = ?', {result[1].id})
    end
  end
  return false, message
end

function QBCore.Functions.IsLicenseInUse(license)
  local players = GetPlayers()
  for _, player in pairs(players) do
    local identifiers = GetPlayerIdentifiers(player)
    for _, id in pairs(identifiers) do
      if string.find(id, 'license') then
        local playerLicense = id
        if playerLicense == license then
          return true
        end
      end
    end
  end
  return false
end

-- function QBCore.Functions.IsWhitelisted(source)
--     local src = source
--     local license = QBCore.Functions.GetIdentifier(src, 'license')
-- 	if QBCore.Config.Server.whitelist then
-- 		local result = exports.oxmysql:scalarSync('SELECT license FROM whitelist WHERE license = ?', {license})
-- 		if result then
--             if result == license then
--                 return true
--             end
-- 		end
--     end
--     return false
-- end

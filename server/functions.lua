-- Callbacks

function QBCore.Functions.CreateCallback(name, cb)
    QBCore.ServerCallbacks[name] = cb
end

function QBCore.Functions.TriggerClientCallback(name, source, ...)
    local cb = nil
    local args = { ... }

    if QBCore.Functions.IsFunction(args[1]) then
        cb = args[1]
        table.remove(args, 1)
    end

    QBCore.ClientCallbacks[name] = {
        callback = cb,
        promise = promise.new()
    }

    TriggerClientEvent('QBCore:Client:TriggerClientCallback', source, name, table.unpack(args))

    if cb == nil then
        Citizen.Await(QBCore.ClientCallbacks[name].promise)
        return QBCore.ClientCallbacks[name].promise.value
    end
end

-- Functions

function QBCore.Functions.GetDatabaseInfo()
    local details = {
        exists = false,
        database = '',
    }
    local connectionString = GetConvar('mysql_connection_string', '')

    if connectionString == '' then
        return details
    elseif connectionString:find('mysql://') then
        connectionString = connectionString:sub(9, -1)
        details.database = connectionString:sub(connectionString:find('/') + 1, -1):gsub('[%?]+[%w%p]*$', '')
        details.exists = true
        return details
    else
        connectionString = { string.strsplit(';', connectionString) }

        for i = 1, #connectionString do
            local v = connectionString[i]
            if v:match('database') then
                details.database = v:sub(10, #v)
                details.exists = true
                return details
            end
        end
    end
end

function QBCore.Functions.GetIdentifier(source, idtype)
    if GetConvarInt('sv_fxdkMode', 0) == 1 then return 'license:fxdk' end
    return GetPlayerIdentifierByType(source, idtype or 'license')
end

function QBCore.Functions.IsLicenseInUse(license)
    local players = GetPlayers()
    for _, player in pairs(players) do
        local playerLicense = QBCore.Functions.GetIdentifier(player, 'license')
        if playerLicense == license then return true end
    end
    return false
end

function QBCore.Functions.HasPermission(source, permission)
    if type(permission) == 'string' then
        if IsPlayerAceAllowed(source, permission) then return true end
    elseif type(permission) == 'table' then
        for _, permLevel in pairs(permission) do
            if IsPlayerAceAllowed(source, permLevel) then return true end
        end
    end
    return false
end

function QBCore.Functions.IsWhitelisted(source)
    if not QBCore.Config.Server.Whitelist then return true end
    if QBCore.Functions.HasPermission(source, QBCore.Config.Server.WhitelistPermission) then return true end
    return false
end

function QBCore.Functions.IsPlayerBanned(source)
    local plicense = QBCore.Functions.GetIdentifier(source, 'license')
    local result = MySQL.single.await('SELECT id, reason, expire FROM bans WHERE license = ?', { plicense })
    if not result then return false end
    if os.time() < result.expire then
        local timeTable = os.date('*t', tonumber(result.expire))
        return true, 'You have been banned from the server:\n' .. result.reason .. '\nYour ban expires ' .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
    else
        MySQL.query('DELETE FROM bans WHERE id = ?', { result.id })
    end
    return false
end

function QBCore.Functions.GetPlayer(source)
    if tonumber(source) then
        return QBCore.Players[tonumber(source)]
    else
        return QBCore.Players[QBCore.Functions.GetSource(source)]
    end
end

function QBCore.Functions.GetQBPlayers()
    return QBCore.Players
end

function QBCore.Functions.CreateUseableItem(item, data)
    local rawFunc = nil

    if type(data) == 'table' then
        if rawget(data, '__cfx_functionReference') then
            rawFunc = data
        elseif data.cb and rawget(data.cb, '__cfx_functionReference') then
            rawFunc = data.cb
        elseif data.callback and rawget(data.callback, '__cfx_functionReference') then
            rawFunc = data.callback
        end
    elseif type(data) == 'function' then
        rawFunc = data
    end

    if rawFunc then
        QBCore.UsableItems[item] = {
            func = rawFunc,
            resource = GetInvokingResource()
        }
    end
end

-- Player Setup

function QBCore.Functions.CreateCitizenId()
    local CitizenId = tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(5)):upper()
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE citizenid = ?) AS uniqueCheck', { CitizenId })
    if result == 0 then return CitizenId end
    return QBCore.Functions.CreateCitizenId()
end

function QBCore.Functions.CreateAccountNumber()
    local AccountNumber = 'US0' .. math.random(1, 9) .. 'QBCore' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.account")) = ?) AS uniqueCheck', { AccountNumber })
    if result == 0 then return AccountNumber end
    return QBCore.Functions.CreateAccountNumber()
end

function QBCore.Functions.CreatePhoneNumber()
    local PhoneNumber = math.random(100, 999) .. math.random(1000000, 9999999)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.phone")) = ?) AS uniqueCheck', { PhoneNumber })
    if result == 0 then return PhoneNumber end
    return QBCore.Functions.CreatePhoneNumber()
end

function QBCore.Functions.CreateFingerId()
    local FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.fingerprint")) = ?) AS uniqueCheck', { FingerId })
    if result == 0 then return FingerId end
    return QBCore.Functions.CreateFingerId()
end

function QBCore.Functions.CreateWalletId()
    local WalletId = 'QB-' .. math.random(11111111, 99999999)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.walletid")) = ?) AS uniqueCheck', { WalletId })
    if result == 0 then return WalletId end
    return QBCore.Functions.CreateWalletId()
end

function QBCore.Functions.CreateSerialNumber()
    local SerialNumber = math.random(11111111, 99999999)
    local result = MySQL.prepare.await('SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.phonedata.SerialNumber")) = ?) AS uniqueCheck', { SerialNumber })
    if result == 0 then return SerialNumber end
    return QBCore.Functions.CreateSerialNumber()
end

-- Database Verification

local readyFunction = MySQL.ready
local databaseConnected, bansTableExists = readyFunction == nil, readyFunction == nil
if readyFunction ~= nil then
    MySQL.ready(function()
        databaseConnected = true
        local DatabaseInfo = QBCore.Functions.GetDatabaseInfo()
        if not DatabaseInfo or not DatabaseInfo.exists then return end
        local result = MySQL.query.await('SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = ? AND TABLE_NAME = "bans";', { DatabaseInfo.database })
        if result and result[1] then
            bansTableExists = true
        end
    end)
end

-- Handle player connect

AddEventHandler('playerConnecting', function(name, _, deferrals)
    local src = source
    deferrals.defer()
    if QBCore.Config.Server.Closed and not IsPlayerAceAllowed(src, 'qbadmin.join') then
        return deferrals.done(QBCore.Config.Server.ClosedReason)
    end
    if not databaseConnected then
        return deferrals.done(Lang:t('error.connecting_database_error'))
    end
    if QBCore.Config.Server.Whitelist then
        Wait(0)
        deferrals.update(string.format(Lang:t('info.checking_whitelisted'), name))
        if not QBCore.Functions.IsWhitelisted(src) then
            return deferrals.done(Lang:t('error.not_whitelisted'))
        end
    end
    Wait(0)
    deferrals.update(string.format('Hello %s. Your license is being checked', name))
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    if not license then
        return deferrals.done(Lang:t('error.no_valid_license'))
    elseif QBCore.Config.Server.CheckDuplicateLicense and QBCore.Functions.IsLicenseInUse(license) then
        return deferrals.done(Lang:t('error.duplicate_license'))
    end
    Wait(0)
    deferrals.update(string.format(Lang:t('info.checking_ban'), name))
    if not bansTableExists then
        return deferrals.done(Lang:t('error.ban_table_not_found'))
    end
    local success, isBanned, reason = pcall(QBCore.Functions.IsPlayerBanned, src)
    if not success then return deferrals.done(Lang:t('error.connecting_database_error')) end
    if isBanned then return deferrals.done(reason) end
    Wait(0)
    deferrals.update(string.format(Lang:t('info.join_server'), name))
    deferrals.done()
end)

-- Handle player disconnect

AddEventHandler('playerDropped', function(reason)
    local src = source
    local state = Player(src).state
    if not state['citizenid'] then return end
    local playerName = GetPlayerName(src) or 'Unknown'
    local license = state['license'] or 'Unknown License'
    TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Dropped', 'red', '**' .. playerName .. '** (' .. license .. ') left..\n **Reason:** ' .. reason)
    TriggerEvent('QBCore:Server:PlayerDropped', src)
    QBCore.Player.Save(src)
    if GetResourceState('qb-inventory') ~= 'missing' then
        exports['qb-inventory']:SaveInventory(src)
    end
    for _, key in pairs(GetStateBagKeys('player:' .. src)) do
        state:set(key, nil, true)
    end
    QBCore.Player_Buckets[license] = nil
end)

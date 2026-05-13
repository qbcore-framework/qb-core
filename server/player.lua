--[[
    Getting a player:

        local Player = exports['qb-core']:GetPlayer(source)          -- online, by server id
        local Player = exports['qb-core']:GetPlayerByCitizenId(cid)  -- online, by citizenid
        local Player = exports['qb-core']:GetOfflinePlayerByCitizenId(cid) -- offline, DB lookup

    Calling functions:

        Player.AddMoney('cash', 500, 'reason')
        Player.RemoveMoney('bank', 200, 'reason')
        Player.SetJob('police', 2)
        Player.SetMetaData('hunger', 100)
        Player.Save()

        -- Old style (also still works):
        Player.Functions.AddMoney('cash', 500, 'reason')
]]

QBCore.Players = {}
QBCore.Player = {}
local resourceName = GetCurrentResourceName()

-- ============================================================
-- Player Metatable
-- ============================================================

local varargMethods = {
    'GetPlayerData', 'UpdateClient', 'SetJob', 'SetGang', 'Notify', 'HasItem',
    'SetJobDuty', 'SetPlayerData', 'SetMetaData', 'GetMetaData',
    'AddRep', 'RemoveRep', 'GetRep', 'AddMoney', 'RemoveMoney', 'SetMoney', 'GetMoney',
    'AddMethod', 'AddField',
}
local noargMethods = { 'GetName', 'Save', 'Logout' }

local function buildMethodTable(player)
    local t = {}
    for _, name in ipairs(varargMethods) do
        local fn = player[name]
        t[name] = function(...) return fn(player, ...) end
    end
    for _, name in ipairs(noargMethods) do
        local fn = player[name]
        t[name] = function() return fn(player) end
    end
    return t
end

local Player = {}
Player.__index = Player

function Player.new(PlayerData, Offline)
    local self = setmetatable({}, Player)
    self.PlayerData = PlayerData
    self.Offline = Offline
    self.Functions = buildMethodTable(self)
    self.Functions.UpdatePlayerData = self.Functions.UpdateClient
    return self
end

function Player:GetPlayerData()
    return self.PlayerData
end

function Player:UpdateClient(key, val)
    if self.Offline then return end
    TriggerEvent('QBCore:Player:SetPlayerData', self.PlayerData)
    if key and val then
        TriggerClientEvent('QBCore:Player:UpdatePlayerDataField', self.PlayerData.source, key, val)
    else
        TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
    end
end

function Player:SetJob(job, grade)
    job = job:lower()
    grade = grade or '0'
    if not QBCore.Shared.Jobs[job] then return false end
    self.PlayerData.job = {
        name   = job,
        label  = QBCore.Shared.Jobs[job].label,
        onduty = QBCore.Shared.Jobs[job].defaultDuty,
        type   = QBCore.Shared.Jobs[job].type or 'none',
        grade  = {
            name    = 'No Grades',
            level   = 0,
            payment = 30,
            isboss  = false
        }
    }
    local gradeKey = tostring(grade)
    local jobGradeInfo = QBCore.Shared.Jobs[job].grades[gradeKey]
    if jobGradeInfo then
        self.PlayerData.job.grade.name    = jobGradeInfo.name
        self.PlayerData.job.grade.level   = tonumber(gradeKey)
        self.PlayerData.job.grade.payment = jobGradeInfo.payment
        self.PlayerData.job.grade.isboss  = jobGradeInfo.isboss or false
        self.PlayerData.job.isboss        = jobGradeInfo.isboss or false
    end
    if not self.Offline then
        self:UpdateClient('job', self.PlayerData.job)
        TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
        TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
    end
    return true
end

function Player:SetGang(gang, grade)
    gang = gang:lower()
    grade = grade or '0'
    if not QBCore.Shared.Gangs[gang] then return false end
    self.PlayerData.gang = {
        name  = gang,
        label = QBCore.Shared.Gangs[gang].label,
        grade = {
            name   = 'No Grades',
            level  = 0,
            isboss = false
        }
    }
    local gradeKey = tostring(grade)
    local gangGradeInfo = QBCore.Shared.Gangs[gang].grades[gradeKey]
    if gangGradeInfo then
        self.PlayerData.gang.grade.name   = gangGradeInfo.name
        self.PlayerData.gang.grade.level  = tonumber(gradeKey)
        self.PlayerData.gang.grade.isboss = gangGradeInfo.isboss or false
        self.PlayerData.gang.isboss       = gangGradeInfo.isboss or false
    end
    if not self.Offline then
        self:UpdateClient('gang', self.PlayerData.gang)
        TriggerEvent('QBCore:Server:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
        TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
    end
    return true
end

function Player:Notify(text, notifyType, length)
    TriggerClientEvent('QBCore:Notify', self.PlayerData.source, text, notifyType, length)
end

function Player:HasItem(items, amount)
    return QBCore.Functions.HasItem(self.PlayerData.source, items, amount)
end

function Player:GetName()
    local charinfo = self.PlayerData.charinfo
    return charinfo.firstname .. ' ' .. charinfo.lastname
end

function Player:SetJobDuty(onDuty)
    self.PlayerData.job.onduty = not not onDuty
    TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
    TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
    self:UpdateClient('job', self.PlayerData.job)
end

function Player:SetPlayerData(key, val)
    if not key or type(key) ~= 'string' then return end
    self.PlayerData[key] = val
    self:UpdateClient(key, val)
end

function Player:SetMetaData(meta, val)
    if not meta or type(meta) ~= 'string' then return end
    if meta == 'hunger' or meta == 'thirst' then
        val = val > 100 and 100 or val
    end
    self.PlayerData.metadata[meta] = val
    self:UpdateClient('metadata', self.PlayerData.metadata)
end

function Player:GetMetaData(meta)
    if not meta or type(meta) ~= 'string' then return end
    return self.PlayerData.metadata[meta]
end

function Player:AddRep(rep, amount)
    if not rep or not amount then return end
    local addAmount = tonumber(amount)
    local currentRep = self.PlayerData.metadata['rep'][rep] or 0
    self.PlayerData.metadata['rep'][rep] = currentRep + addAmount
    self:UpdateClient('metadata', self.PlayerData.metadata)
end

function Player:RemoveRep(rep, amount)
    if not rep or not amount then return end
    local removeAmount = tonumber(amount)
    local currentRep = self.PlayerData.metadata['rep'][rep] or 0
    self.PlayerData.metadata['rep'][rep] = math.max(0, currentRep - removeAmount)
    self:UpdateClient('metadata', self.PlayerData.metadata)
end

function Player:GetRep(rep)
    if not rep then return end
    return self.PlayerData.metadata['rep'][rep] or 0
end

function Player:AddMoney(moneytype, amount, reason)
    reason = reason or 'unknown'
    moneytype = moneytype:lower()
    amount = tonumber(amount)
    if amount < 0 then return end
    if not self.PlayerData.money[moneytype] then return false end
    self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
    if not self.Offline then
        self:UpdateClient('money', self.PlayerData.money)
        local logExtra = amount > 100000
        TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen',
            '**' .. GetPlayerName(self.PlayerData.source) ..
            ' (citizenid: ' .. self.PlayerData.citizenid ..
            ' | id: ' .. self.PlayerData.source .. ')** $' .. amount ..
            ' (' .. moneytype .. ') added, new ' .. moneytype ..
            ' balance: ' .. self.PlayerData.money[moneytype] ..
            ' reason: ' .. reason, logExtra)
        TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false)
        TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'add', reason)
        TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'add', reason)
    end
    return true
end

function Player:RemoveMoney(moneytype, amount, reason)
    reason = reason or 'unknown'
    moneytype = moneytype:lower()
    amount = tonumber(amount)
    if amount < 0 then return end
    if not self.PlayerData.money[moneytype] then return false end
    for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
        if mtype == moneytype and (self.PlayerData.money[moneytype] - amount) < 0 then
            return false
        end
    end
    if self.PlayerData.money[moneytype] - amount < QBCore.Config.Money.MinusLimit then return false end
    self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
    if not self.Offline then
        self:UpdateClient('money', self.PlayerData.money)
        local logExtra = amount > 100000
        TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red',
            '**' .. GetPlayerName(self.PlayerData.source) ..
            ' (citizenid: ' .. self.PlayerData.citizenid ..
            ' | id: ' .. self.PlayerData.source .. ')** $' .. amount ..
            ' (' .. moneytype .. ') removed, new ' .. moneytype ..
            ' balance: ' .. self.PlayerData.money[moneytype] ..
            ' reason: ' .. reason, logExtra)
        TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true)
        if moneytype == 'bank' then
            TriggerClientEvent('qb-phone:client:RemoveBankMoney', self.PlayerData.source, amount)
        end
        TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'remove', reason)
        TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'remove', reason)
    end
    return true
end

function Player:SetMoney(moneytype, amount, reason)
    reason = reason or 'unknown'
    moneytype = moneytype:lower()
    amount = tonumber(amount)
    if amount < 0 then return false end
    if not self.PlayerData.money[moneytype] then return false end
    local difference = amount - self.PlayerData.money[moneytype]
    self.PlayerData.money[moneytype] = amount
    if not self.Offline then
        self:UpdateClient('money', self.PlayerData.money)
        TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'SetMoney', 'green',
            '**' .. GetPlayerName(self.PlayerData.source) ..
            ' (citizenid: ' .. self.PlayerData.citizenid ..
            ' | id: ' .. self.PlayerData.source .. ')** $' .. amount ..
            ' (' .. moneytype .. ') set, new ' .. moneytype ..
            ' balance: ' .. self.PlayerData.money[moneytype] ..
            ' reason: ' .. reason)
        TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, math.abs(difference), difference < 0)
        TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'set', reason)
        TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'set', reason)
    end
    return true
end

function Player:GetMoney(moneytype)
    if not moneytype then return false end
    return self.PlayerData.money[moneytype:lower()]
end

function Player:Save()
    if self.Offline then
        QBCore.Player.SaveOffline(self.PlayerData)
    else
        QBCore.Player.Save(self.PlayerData.source)
    end
end

function Player:Logout()
    if self.Offline then return end
    QBCore.Player.Logout(self.PlayerData.source)
end

function Player:AddMethod(methodName, handler)
    if type(handler) ~= 'function' then return end
    self[methodName] = handler
    self.Functions[methodName] = handler
end

function Player:AddField(fieldName, data)
    if type(data) == 'function' then return end
    self[fieldName] = data
end

-- ============================================================
-- Login / Logout
-- ============================================================

local function decodePlayerFields(PlayerData)
    PlayerData.money    = json.decode(PlayerData.money)
    PlayerData.job      = json.decode(PlayerData.job)
    PlayerData.gang     = json.decode(PlayerData.gang)
    PlayerData.position = json.decode(PlayerData.position)
    PlayerData.metadata = json.decode(PlayerData.metadata)
    PlayerData.charinfo = json.decode(PlayerData.charinfo)
end

function QBCore.Player.Login(source, citizenid, newData)
    if source and source ~= '' then
        if citizenid then
            local license = QBCore.Functions.GetIdentifier(source, 'license')
            local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
            if PlayerData and license == PlayerData.license then
                decodePlayerFields(PlayerData)
                QBCore.Player.CheckPlayerData(source, PlayerData)
            else
                DropPlayer(source, Lang:t('info.exploit_dropped'))
                TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' Has Been Dropped For Character Joining Exploit', false)
            end
        else
            QBCore.Player.CheckPlayerData(source, newData)
        end
        return true
    else
        QBCore.ShowError(resourceName, 'ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!')
        return false
    end
end

function QBCore.Player.Logout(source)
    TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
    TriggerEvent('QBCore:Server:OnPlayerUnload', source)
    TriggerClientEvent('QBCore:Player:UpdatePlayerData', source)
    Wait(200)
    QBCore.Players[source] = nil
end

-- ============================================================
-- Offline Player Lookups
-- ============================================================

function QBCore.Player.GetOfflinePlayer(citizenid)
    if citizenid then
        local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
        if PlayerData then
            decodePlayerFields(PlayerData)
            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
end

function QBCore.Player.GetPlayerByLicense(license)
    if license then
        local source = QBCore.Functions.GetSource(license)
        if source > 0 then
            return QBCore.Players[source]
        else
            return QBCore.Player.GetOfflinePlayerByLicense(license)
        end
    end
    return nil
end

function QBCore.Player.GetOfflinePlayerByLicense(license)
    if license then
        local PlayerData = MySQL.prepare.await('SELECT * FROM players where license = ?', { license })
        if PlayerData then
            decodePlayerFields(PlayerData)
            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
end

-- ============================================================
-- Unique ID Generators
-- ============================================================

local function createUniqueId(generator, query)
    local value = generator()
    local result = MySQL.prepare.await(query, { value })
    if result == 0 then return value end
    return createUniqueId(generator, query)
end

function QBCore.Player.CreateCitizenId()
    return createUniqueId(
        function() return tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(5)):upper() end,
        'SELECT EXISTS(SELECT 1 FROM players WHERE citizenid = ?) AS uniqueCheck'
    )
end

function QBCore.Functions.CreateAccountNumber()
    return createUniqueId(
        function() return 'US0' .. math.random(1, 9) .. 'QBCore' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99) end,
        'SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.account")) = ?) AS uniqueCheck'
    )
end

function QBCore.Functions.CreatePhoneNumber()
    return createUniqueId(
        function() return math.random(100, 999) .. math.random(1000000, 9999999) end,
        'SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.phone")) = ?) AS uniqueCheck'
    )
end

function QBCore.Player.CreateFingerId()
    return createUniqueId(
        function() return tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4)) end,
        'SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.fingerprint")) = ?) AS uniqueCheck'
    )
end

function QBCore.Player.CreateWalletId()
    return createUniqueId(
        function() return 'QB-' .. math.random(11111111, 99999999) end,
        'SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.walletid")) = ?) AS uniqueCheck'
    )
end

function QBCore.Player.CreateSerialNumber()
    return createUniqueId(
        function() return math.random(11111111, 99999999) end,
        'SELECT EXISTS(SELECT 1 FROM players WHERE JSON_UNQUOTE(JSON_EXTRACT(metadata, "$.phonedata.SerialNumber")) = ?) AS uniqueCheck'
    )
end

-- ============================================================
-- Data Validation / Construction
-- ============================================================

local DynamicDefaults = {
    citizenid    = QBCore.Player.CreateCitizenId,
    phone        = QBCore.Functions.CreatePhoneNumber,
    account      = QBCore.Functions.CreateAccountNumber,
    fingerprint  = QBCore.Player.CreateFingerId,
    walletid     = QBCore.Player.CreateWalletId,
    SerialNumber = QBCore.Player.CreateSerialNumber,
    bloodtype    = function()
        return QBCore.Shared.GetRandomElement(QBCore.Config.Player.Bloodtypes)
    end
}

local function applyDynamicDefaults(tbl)
    for k, v in pairs(tbl) do
        if type(v) == 'table' then
            applyDynamicDefaults(v)
        elseif v == '__GENERATED__' then
            local gen = DynamicDefaults[k]
            if gen then tbl[k] = gen() end
        end
    end
end

local function mergeDefaults(dest, src)
    for k, v in pairs(src) do
        if type(v) == 'table' then
            if type(dest[k]) ~= 'table' then dest[k] = {} end
            mergeDefaults(dest[k], v)
        elseif dest[k] == nil then
            dest[k] = v
        end
    end
end

local function mergeWithGenerators(dest, src)
    for k, v in pairs(src) do
        if type(v) == 'table' then
            if type(dest[k]) ~= 'table' then dest[k] = {} end
            mergeWithGenerators(dest[k], v)
        elseif dest[k] == nil then
            if v == '__GENERATED__' then
                local gen = DynamicDefaults[k]
                if gen then
                    dest[k] = gen()
                else
                    dest[k] = v
                    print(("Warning: no generator for '%s'"):format(k))
                end
            else
                dest[k] = v
            end
        end
    end
end

local function pruneExtras(dest, src)
    for k, v in pairs(dest) do
        if src[k] == nil then
            dest[k] = nil
        elseif type(v) == 'table' and type(src[k]) == 'table' then
            pruneExtras(v, src[k])
        end
    end
end

function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData = PlayerData or {}
    local Offline = not source

    local validatedJob = false
    if PlayerData.job and PlayerData.job.name ~= nil and PlayerData.job.grade and PlayerData.job.grade.level ~= nil then
        local jobInfo = QBCore.Shared.Jobs[PlayerData.job.name]
        if jobInfo then
            local jobGradeInfo = jobInfo.grades[tostring(PlayerData.job.grade.level)]
            if jobGradeInfo then
                PlayerData.job.label         = jobInfo.label
                PlayerData.job.grade.name    = jobGradeInfo.name
                PlayerData.job.grade.payment = jobGradeInfo.payment
                PlayerData.job.grade.isboss  = jobGradeInfo.isboss or false
                PlayerData.job.isboss        = jobGradeInfo.isboss or false
                validatedJob                 = true
            end
        end
    end
    if not validatedJob then PlayerData.job = nil end

    local validatedGang = false
    if PlayerData.gang and PlayerData.gang.name ~= nil and PlayerData.gang.grade and PlayerData.gang.grade.level ~= nil then
        local gangInfo = QBCore.Shared.Gangs[PlayerData.gang.name]
        if gangInfo then
            local gangGradeInfo = gangInfo.grades[tostring(PlayerData.gang.grade.level)]
            if gangGradeInfo then
                PlayerData.gang.label         = gangInfo.label
                PlayerData.gang.grade.name    = gangGradeInfo.name
                PlayerData.gang.grade.isboss  = gangGradeInfo.isboss or false
                PlayerData.gang.isboss        = gangGradeInfo.isboss or false
                validatedGang                 = true
            end
        end
    end
    if not validatedGang then PlayerData.gang = nil end

    local defaults = json.decode(LoadResourceFile(resourceName, 'shared/player_defaults.json'))

    if not PlayerData.citizenid then
        applyDynamicDefaults(defaults)
        mergeDefaults(PlayerData, defaults)
    else
        pruneExtras(PlayerData, defaults)
        mergeWithGenerators(PlayerData, defaults)
    end

    if source then
        PlayerData.source  = source
        PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(source, 'license')
        PlayerData.name    = GetPlayerName(source)
    end

    if PlayerData.job and QBCore.Shared.ForceJobDefaultDutyAtLogin then
        local jobInfo = QBCore.Shared.Jobs[PlayerData.job.name]
        if jobInfo then
            PlayerData.job.onduty = jobInfo.defaultDuty
        end
    end

    if GetResourceState('qb-inventory') ~= 'missing' then
        PlayerData.items = exports['qb-inventory']:LoadInventory(PlayerData.source, PlayerData.citizenid)
    end

    return QBCore.Player.CreatePlayer(PlayerData, Offline)
end

function QBCore.Player.CreatePlayer(PlayerData, Offline)
    local player = Player.new(PlayerData, Offline)
    if Offline then return player end
    QBCore.Players[PlayerData.source] = player
    QBCore.Player.Save(PlayerData.source)
    TriggerEvent('QBCore:Server:PlayerLoaded', player)
    player:UpdateClient()
end

-- ============================================================
-- Runtime Extension API
-- ============================================================

local function forEachPlayer(ids, fn)
    local idType = type(ids)
    if idType == 'number' then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do fn(v) end
        elseif QBCore.Players[ids] then
            fn(QBCore.Players[ids])
        end
    elseif idType == 'table' and table.type(ids) == 'array' then
        for i = 1, #ids do forEachPlayer(ids[i], fn) end
    end
end

function QBCore.Functions.AddPlayerMethod(ids, methodName, handler)
    forEachPlayer(ids, function(v) v:AddMethod(methodName, handler) end)
end

function QBCore.Functions.AddPlayerField(ids, fieldName, data)
    forEachPlayer(ids, function(v) v:AddField(fieldName, data) end)
end

-- ============================================================
-- Save / Persistence
-- ============================================================

function QBCore.Player.Save(source)
    local ped = GetPlayerPed(source)
    local pcoords = GetEntityCoords(ped)
    local PlayerData = QBCore.Players[source].PlayerData
    if PlayerData then
        MySQL.insert('INSERT INTO players (citizenid, cid, license, name, money, charinfo, job, gang, position, metadata) VALUES (:citizenid, :cid, :license, :name, :money, :charinfo, :job, :gang, :position, :metadata) ON DUPLICATE KEY UPDATE cid = :cid, name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata', {
            citizenid = PlayerData.citizenid,
            cid       = tonumber(PlayerData.cid),
            license   = PlayerData.license,
            name      = PlayerData.name,
            money     = json.encode(PlayerData.money),
            charinfo  = json.encode(PlayerData.charinfo),
            job       = json.encode(PlayerData.job),
            gang      = json.encode(PlayerData.gang),
            position  = json.encode(pcoords),
            metadata  = json.encode(PlayerData.metadata)
        })
        if GetResourceState('qb-inventory') ~= 'missing' then exports['qb-inventory']:SaveInventory(source) end
        QBCore.ShowSuccess(resourceName, PlayerData.name .. ' PLAYER SAVED!')
    else
        QBCore.ShowError(resourceName, 'ERROR QBCORE.PLAYER.SAVE - PLAYERDATA IS EMPTY!')
    end
end

function QBCore.Player.SaveOffline(PlayerData)
    if PlayerData then
        MySQL.insert('INSERT INTO players (citizenid, cid, license, name, money, charinfo, job, gang, position, metadata) VALUES (:citizenid, :cid, :license, :name, :money, :charinfo, :job, :gang, :position, :metadata) ON DUPLICATE KEY UPDATE cid = :cid, name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata', {
            citizenid = PlayerData.citizenid,
            cid       = tonumber(PlayerData.cid),
            license   = PlayerData.license,
            name      = PlayerData.name,
            money     = json.encode(PlayerData.money),
            charinfo  = json.encode(PlayerData.charinfo),
            job       = json.encode(PlayerData.job),
            gang      = json.encode(PlayerData.gang),
            position  = json.encode(PlayerData.position),
            metadata  = json.encode(PlayerData.metadata)
        })
        if GetResourceState('qb-inventory') ~= 'missing' then exports['qb-inventory']:SaveInventory(PlayerData, true) end
        QBCore.ShowSuccess(resourceName, PlayerData.name .. ' OFFLINE PLAYER SAVED!')
    else
        QBCore.ShowError(resourceName, 'ERROR QBCORE.PLAYER.SAVEOFFLINE - PLAYERDATA IS EMPTY!')
    end
end

-- ============================================================
-- Character Deletion
-- ============================================================

local playertables = {
    { table = 'players' },
    { table = 'apartments' },
    { table = 'bank_accounts' },
    { table = 'crypto_transactions' },
    { table = 'phone_invoices' },
    { table = 'phone_messages' },
    { table = 'playerskins' },
    { table = 'player_contacts' },
    { table = 'player_houses' },
    { table = 'player_mails' },
    { table = 'player_outfits' },
    { table = 'player_vehicles' }
}

function QBCore.Player.DeleteCharacter(source, citizenid)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local result  = MySQL.scalar.await('SELECT license FROM players where citizenid = ?', { citizenid })
    if license == result then
        local query      = 'DELETE FROM %s WHERE citizenid = ?'
        local tableCount = #playertables
        local queries    = {}
        for i = 1, tableCount do
            queries[i] = { query = query:format(playertables[i].table), values = { citizenid } }
        end
        MySQL.transaction(queries, function(result2)
            if result2 then
                TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Deleted', 'red',
                    '**' .. GetPlayerName(source) .. '** ' .. license .. ' deleted **' .. citizenid .. '**..')
            end
        end)
    else
        DropPlayer(source, Lang:t('info.exploit_dropped'))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' Has Been Dropped For Character Deletion Exploit', true)
    end
end

function QBCore.Player.ForceDeleteCharacter(citizenid)
    local result = MySQL.scalar.await('SELECT license FROM players where citizenid = ?', { citizenid })
    if result then
        local query      = 'DELETE FROM %s WHERE citizenid = ?'
        local tableCount = #playertables
        local queries    = {}
        local existing   = QBCore.Functions.GetPlayerByCitizenId(citizenid)
        if existing then
            DropPlayer(existing.PlayerData.source, 'An admin deleted the character which you are currently using')
        end
        for i = 1, tableCount do
            queries[i] = { query = query:format(playertables[i].table), values = { citizenid } }
        end
        MySQL.transaction(queries, function(result2)
            if result2 then
                TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Force Deleted', 'red',
                    'Character **' .. citizenid .. '** got deleted')
            end
        end)
    end
end

-- ============================================================
-- Export Bridge
-- ============================================================

local function buildInterface(internalPlayer)
    if not internalPlayer then return nil end
    local iface = buildMethodTable(internalPlayer)
    iface.PlayerData = internalPlayer.PlayerData
    return iface
end

exports('GetPlayer', function(source)
    return buildInterface(QBCore.Players[tonumber(source)])
end)

exports('GetPlayerByCitizenId', function(citizenid)
    for _, player in pairs(QBCore.Players) do
        if player.PlayerData.citizenid == citizenid then
            return buildInterface(player)
        end
    end
    return nil
end)

exports('GetOfflinePlayerByCitizenId', function(citizenid)
    return buildInterface(QBCore.Player.GetOfflinePlayer(citizenid))
end)

exports('GetPlayerByLicense', function(license)
    return buildInterface(QBCore.Player.GetPlayerByLicense(license))
end)

exports('GetOfflinePlayerByLicense', function(license)
    return buildInterface(QBCore.Player.GetOfflinePlayerByLicense(license))
end)

exports('AddPlayerMethod', function(ids, methodName, handler)
    QBCore.Functions.AddPlayerMethod(ids, methodName, handler)
end)

exports('AddPlayerField', function(ids, fieldName, data)
    QBCore.Functions.AddPlayerField(ids, fieldName, data)
end)

PaycheckInterval()

QBCore.Players            = {}
QBCore.Player             = {}
QBCore.PlayersByCitizenId = {}
local resourceName        = GetCurrentResourceName()

-- ─────────────────────────── Player class ───────────────────────────────────

local varargMethods       = {
    'GetPlayerData', 'UpdateClient', 'SetJob', 'SetGang', 'Notify', 'HasItem',
    'SetJobDuty', 'SetPlayerData', 'SetMetaData', 'GetMetaData',
    'AddRep', 'RemoveRep', 'GetRep', 'AddMoney', 'RemoveMoney', 'SetMoney', 'GetMoney',
    'AddMethod', 'AddField',
}
local noargMethods        = { 'GetName', 'Save', 'Logout' }

local function isCallable(value)
    if type(value) == 'function' then return true end
    if type(value) == 'table' and type(rawget(value, '__cfx_functionReference')) == 'string' then return true end
    local mt = getmetatable(value)
    return mt and type(mt.__call) == 'function'
end

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

local Player   = {}
Player.__index = Player

function Player.new(PlayerData, Offline)
    local self                      = setmetatable({}, Player)
    self.PlayerData                 = PlayerData
    self.Offline                    = Offline or false
    self.Functions                  = buildMethodTable(self)
    self.Functions.UpdatePlayerData = self.Functions.UpdateClient
    return self
end

-- ─────────────────────────── instance methods ───────────────────────────────

function Player:GetPlayerData()
    return self.PlayerData
end

function Player:UpdateClient(key, val)
    if self.Offline then return end
    if key then
        TriggerEvent('QBCore:Server:OnPlayerUpdated', self.PlayerData.source, key, val)
        TriggerClientEvent('QBCore:Client:OnPlayerUpdated', self.PlayerData.source, key, val)
    else
        TriggerEvent('QBCore:Player:SetPlayerData', self.PlayerData)
        TriggerEvent('QBCore:Server:OnPlayerUpdated', self.PlayerData.source, 'all', self.PlayerData)
        TriggerClientEvent('QBCore:Client:OnPlayerUpdated', self.PlayerData.source, 'all', self.PlayerData)
    end
end

function Player:SetJob(job, grade)
    job   = job:lower()
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
            isboss  = false,
        }
    }
    local gradeKey      = tostring(grade)
    local jobGradeInfo  = QBCore.Shared.Jobs[job].grades[gradeKey]
    if jobGradeInfo then
        self.PlayerData.job.grade.name    = jobGradeInfo.name
        self.PlayerData.job.grade.level   = tonumber(gradeKey)
        self.PlayerData.job.grade.payment = jobGradeInfo.payment
        self.PlayerData.job.grade.isboss  = jobGradeInfo.isboss or false
        self.PlayerData.job.isboss        = jobGradeInfo.isboss or false
    end
    if not self.Offline then
        self:UpdateClient('job', self.PlayerData.job)
    end
    return true
end

function Player:SetGang(gang, grade)
    gang  = gang:lower()
    grade = grade or '0'
    if not QBCore.Shared.Gangs[gang] then return false end
    self.PlayerData.gang = {
        name  = gang,
        label = QBCore.Shared.Gangs[gang].label,
        grade = {
            name   = 'No Grades',
            level  = 0,
            isboss = false,
        }
    }
    local gradeKey       = tostring(grade)
    local gangGradeInfo  = QBCore.Shared.Gangs[gang].grades[gradeKey]
    if gangGradeInfo then
        self.PlayerData.gang.grade.name   = gangGradeInfo.name
        self.PlayerData.gang.grade.level  = tonumber(gradeKey)
        self.PlayerData.gang.grade.isboss = gangGradeInfo.isboss or false
        self.PlayerData.gang.isboss       = gangGradeInfo.isboss or false
    end
    if not self.Offline then
        self:UpdateClient('gang', self.PlayerData.gang)
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
    if not self.Offline then
        self:UpdateClient('job', self.PlayerData.job)
    end
end

function Player:SetPlayerData(key, val)
    if not key or type(key) ~= 'string' then return end
    self.PlayerData[key] = val
    self:UpdateClient(key, val)
end

function Player:SetMetaData(meta, val)
    if not meta or type(meta) ~= 'string' then return end
    if meta == 'hunger' or meta == 'thirst' then
        val = math.min(100, math.max(0, val))
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
    local addAmount                      = tonumber(amount)
    local currentRep                     = self.PlayerData.metadata['rep'][rep] or 0
    self.PlayerData.metadata['rep'][rep] = currentRep + addAmount
    self:UpdateClient('metadata', self.PlayerData.metadata)
end

function Player:RemoveRep(rep, amount)
    if not rep or not amount then return end
    local removeAmount                   = tonumber(amount)
    local currentRep                     = self.PlayerData.metadata['rep'][rep] or 0
    self.PlayerData.metadata['rep'][rep] = math.max(0, currentRep - removeAmount)
    self:UpdateClient('metadata', self.PlayerData.metadata)
end

function Player:GetRep(rep)
    if not rep then return end
    return self.PlayerData.metadata['rep'][rep] or 0
end

function Player:AddMoney(moneytype, amount, reason)
    reason    = reason or 'unknown'
    moneytype = moneytype:lower()
    amount    = tonumber(amount)
    if not amount or amount < 0 then return end
    if not self.PlayerData.money[moneytype] then return false end
    self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
    if not self.Offline then
        self:UpdateClient('money', self.PlayerData.money)
        local logExtra = amount > 100000
        TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen',
            '**' .. self.PlayerData.name ..
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
    reason    = reason or 'unknown'
    moneytype = moneytype:lower()
    amount    = tonumber(amount)
    if not amount or amount < 0 then return end
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
            '**' .. self.PlayerData.name ..
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
    reason    = reason or 'unknown'
    moneytype = moneytype:lower()
    amount    = tonumber(amount)
    if not amount or amount < 0 then return false end
    if not self.PlayerData.money[moneytype] then return false end
    local difference = amount - self.PlayerData.money[moneytype]
    self.PlayerData.money[moneytype] = amount
    if not self.Offline then
        self:UpdateClient('money', self.PlayerData.money)
        TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'SetMoney', 'green',
            '**' .. self.PlayerData.name ..
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
    if type(methodName) ~= 'string' or not isCallable(handler) then return false end
    self[methodName]           = handler
    self.Functions[methodName] = handler
    return true
end

function Player:AddField(fieldName, data)
    if type(fieldName) ~= 'string' or isCallable(data) then return false end
    self[fieldName] = data
    return true
end

-- ─────────────────────────── module-private helpers ─────────────────────────

local function decodePlayerFields(PlayerData)
    PlayerData.money    = json.decode(PlayerData.money)
    PlayerData.job      = json.decode(PlayerData.job)
    PlayerData.gang     = json.decode(PlayerData.gang)
    PlayerData.position = json.decode(PlayerData.position)
    PlayerData.metadata = json.decode(PlayerData.metadata)
    PlayerData.charinfo = json.decode(PlayerData.charinfo)
end

local function applyDefaults(playerData, defaults)
    for key, value in pairs(defaults) do
        if type(value) == 'function' then
            playerData[key] = playerData[key] or value()
        elseif type(value) == 'table' then
            playerData[key] = playerData[key] or {}
            applyDefaults(playerData[key], value)
        else
            playerData[key] = playerData[key] or value
        end
    end
end

-- ─────────────────────────── login / logout ─────────────────────────────────

function QBCore.Player.Login(source, citizenid, newData)
    if source and source ~= '' then
        if citizenid then
            local license    = QBCore.Functions.GetIdentifier(source, 'license')
            local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
            if PlayerData and license == PlayerData.license then
                decodePlayerFields(PlayerData)
                QBCore.Player.CheckPlayerData(source, PlayerData)
            else
                DropPlayer(source, Lang:t('info.exploit_dropped'))
                TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' Has Been Dropped For Character Joining Exploit', false)
                return false
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
    local player = QBCore.Players[source]
    if not player then return end
    player.Functions.Save()
    TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
    TriggerEvent('QBCore:Server:OnPlayerUnload', source)
    QBCore.PlayersByCitizenId[player.PlayerData.citizenid] = nil
    QBCore.Players[source] = nil
end

-- ─────────────────────────── offline player lookups ─────────────────────────

function QBCore.Player.GetOfflinePlayer(citizenid)
    if not citizenid then return nil end
    local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
    if PlayerData then
        decodePlayerFields(PlayerData)
        return QBCore.Player.CheckPlayerData(nil, PlayerData)
    end
    return nil
end

function QBCore.Player.GetPlayerByLicense(license)
    if not license then return nil end
    local source = QBCore.Functions.GetSource(license)
    if source > 0 then
        return QBCore.Players[source]
    else
        return QBCore.Player.GetOfflinePlayerByLicense(license)
    end
end

function QBCore.Player.GetOfflinePlayerByLicense(license)
    if not license then return nil end
    local PlayerData = MySQL.prepare.await('SELECT * FROM players where license = ?', { license })
    if PlayerData then
        decodePlayerFields(PlayerData)
        return QBCore.Player.CheckPlayerData(nil, PlayerData)
    end
    return nil
end

-- ─────────────────────────── data validation / construction ─────────────────

function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData    = PlayerData or {}
    local Offline = not source

    if source then
        PlayerData.source  = source
        PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(source, 'license')
        PlayerData.name    = GetPlayerName(source)
    end

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
                PlayerData.gang.grade.payment = gangGradeInfo.payment
                PlayerData.gang.grade.isboss  = gangGradeInfo.isboss or false
                PlayerData.gang.isboss        = gangGradeInfo.isboss or false
                validatedGang                 = true
            end
        end
    end

    if not validatedGang then PlayerData.gang = nil end

    applyDefaults(PlayerData, QBCore.Config.Player.PlayerDefaults)

    if PlayerData.job and QBCore.Shared.ForceJobDefaultDutyAtLogin then
        local jobInfo = QBCore.Shared.Jobs[PlayerData.job.name]
        if jobInfo then
            PlayerData.job.onduty = jobInfo.defaultDuty
        end
    end

    if not Offline and GetResourceState('qb-inventory') ~= 'missing' then
        PlayerData.items = exports['qb-inventory']:LoadInventory(PlayerData.source, PlayerData.citizenid)
    end

    return QBCore.Player.CreatePlayer(PlayerData, Offline)
end

function QBCore.Player.CreatePlayer(PlayerData, Offline)
    local player = Player.new(PlayerData, Offline)
    if Offline then return player end
    QBCore.Players[PlayerData.source]               = player
    QBCore.PlayersByCitizenId[PlayerData.citizenid] = player
    QBCore.Player.Save(PlayerData.source)
    TriggerEvent('QBCore:Server:PlayerLoaded', player)
    player:UpdateClient()
    return player
end

-- ─────────────────────────── runtime extension API ──────────────────────────

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

-- ─────────────────────────── save / persistence ─────────────────────────────

function QBCore.Player.Save(source)
    local ped        = GetPlayerPed(source)
    local pcoords    = GetEntityCoords(ped)
    local PlayerData = QBCore.Players[source] and QBCore.Players[source].PlayerData
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

-- ─────────────────────────── character deletion ─────────────────────────────

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
    { table = 'player_vehicles' },
}

function QBCore.Player.DeleteCharacter(source, citizenid)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local result  = MySQL.scalar.await('SELECT license FROM players where citizenid = ?', { citizenid })
    if license == result then
        local query   = 'DELETE FROM %s WHERE citizenid = ?'
        local queries = {}
        for i = 1, #playertables do
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
    if not result then return end
    local query    = 'DELETE FROM %s WHERE citizenid = ?'
    local queries  = {}
    local existing = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if existing then
        local src = existing.PlayerData.source
        -- clear refs to prevent playerDropped from saving
        QBCore.Players[src] = nil
        QBCore.PlayersByCitizenId[citizenid] = nil
        DropPlayer(src, 'An admin deleted the character which you are currently using')
    end
    for i = 1, #playertables do
        queries[i] = { query = query:format(playertables[i].table), values = { citizenid } }
    end
    MySQL.transaction(queries, function(result2)
        if result2 then
            TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Force Deleted', 'red',
                'Character **' .. citizenid .. '** got deleted')
        end
    end)
end

-- ─────────────────────────── unique ID generators ───────────────────────────

local function createUniqueId(generator, query, retries)
    retries = (retries or 0) + 1
    if retries > 100 then
        QBCore.ShowError(resourceName, 'createUniqueId: exceeded 100 retries')
        return nil
    end
    local value  = generator()
    local result = MySQL.prepare.await(query, { value })
    if result == 0 then return value end
    return createUniqueId(generator, query, retries)
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

-- ─────────────────────────── export bridge ──────────────────────────────────

local function buildInterface(internalPlayer)
    if not internalPlayer then return nil end
    local iface, methods = {}, {}

    for methodName, handler in pairs(internalPlayer.Functions) do
        if isCallable(handler) then
            iface[methodName] = handler
            methods[methodName] = handler
        end
    end

    for fieldName, data in pairs(internalPlayer) do
        if fieldName ~= 'PlayerData' and fieldName ~= 'Functions' and fieldName ~= 'Offline' and not isCallable(data) then
            iface[fieldName] = data
        end
    end

    iface.PlayerData = internalPlayer.PlayerData
    iface.Functions = methods
    return iface
end

exports('GetPlayer', function(source)
    return buildInterface(QBCore.Players[tonumber(source)])
end)

exports('GetPlayerByCitizenId', function(citizenid)
    return buildInterface(QBCore.PlayersByCitizenId[citizenid])
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

local resourceName = GetCurrentResourceName()

function QBCore.Player.Login(source, citizenid, newData)
    if not source or source == '' then
        QBCore.ShowError(resourceName, 'ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!')
        return false
    end

    if citizenid then
        local license = QBCore.Functions.GetIdentifier(source, 'license')
        local row = MySQL.prepare.await('SELECT * FROM players WHERE citizenid = ?', { citizenid })
        if not row or license ~= row.license then
            DropPlayer(source, Lang:t('info.exploit_dropped'))
            TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' exploit attempt', false)
            return false
        end
        row.money    = json.decode(row.money) or {}
        row.job      = json.decode(row.job) or {}
        row.gang     = json.decode(row.gang) or {}
        row.position = json.decode(row.position) or {}
        row.metadata = json.decode(row.metadata) or {}
        row.charinfo = json.decode(row.charinfo) or {}
        QBCore.Player.CheckPlayerData(source, row)
    else
        QBCore.Player.CheckPlayerData(source, newData)
    end
    return true
end

function QBCore.Player.Logout(source)
    TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
    TriggerEvent('QBCore:Server:OnPlayerUnload', source)
    TriggerClientEvent('QBCore:Player:UpdatePlayerData', source)
    Wait(200)
    QBCore.Players[source] = nil
end

-- JSON DEFAULTS

local DynamicDefaults = {
    citizenid    = QBCore.Functions.CreateCitizenId,
    phone        = QBCore.Functions.CreatePhoneNumber,
    account      = QBCore.Functions.CreateAccountNumber,
    fingerprint  = QBCore.Functions.CreateFingerId,
    walletid     = QBCore.Functions.CreateWalletId,
    SerialNumber = QBCore.Functions.CreateSerialNumber,
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
            if gen then
                tbl[k] = gen()
            end
        end
    end
end

local function mergeDefaults(dest, src)
    for k, v in pairs(src) do
        if type(v) == 'table' then
            if type(dest[k]) ~= 'table' then
                dest[k] = {}
            end
            mergeDefaults(dest[k], v)
        else
            if dest[k] == nil then
                dest[k] = v
            end
        end
    end
end

local function mergeWithGenerators(dest, src)
    for k, v in pairs(src) do
        if type(v) == 'table' then
            if type(dest[k]) ~= 'table' then
                dest[k] = {}
            end
            mergeWithGenerators(dest[k], v)
        else
            -- only act if dest is missing
            if dest[k] == nil then
                if v == '__GENERATED__' then
                    local gen = DynamicDefaults[k]
                    if gen then
                        dest[k] = gen()
                    else
                        -- fallback to literal, or warn
                        dest[k] = v
                        print(("Warning: no generator for '%s'"):format(k))
                    end
                else
                    -- static default
                    dest[k] = v
                end
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

local function LogAndSyncMoneyChange(self, moneytype, amount, changeType, reason, diff)
    local source = self.PlayerData.source
    local citizenid = self.PlayerData.citizenid
    local balance = self.PlayerData.money[moneytype]
    local name = GetPlayerName(source)
    local colorMap = { add = 'lightgreen', remove = 'red', set = 'green' }
    local color = colorMap[changeType] or 'white'
    local action = ({
        add = 'added',
        remove = 'removed',
        set = 'set'
    })[changeType]

    local logMessage = ('**%s (citizenid: %s | id: %s)** $%s (%s) %s, new %s balance: %s reason: %s'):format(
        name, citizenid, source, amount, moneytype, action, moneytype, balance, reason
    )

    local logLabel = ({
        add = 'AddMoney',
        remove = 'RemoveMoney',
        set = 'SetMoney'
    })[changeType]

    local notifyAmount = 100000
    TriggerEvent('qb-log:server:CreateLog', 'playermoney', logLabel, color, logMessage, amount > notifyAmount)

    -- HUD & Client events
    local isRemoval = changeType == 'remove'
    local showAmount = changeType == 'set' and math.abs(diff or 0) or amount

    TriggerClientEvent('hud:client:OnMoneyChange', source, moneytype, showAmount, isRemoval)
    TriggerClientEvent('QBCore:Client:OnMoneyChange', source, moneytype, amount, changeType, reason)
    TriggerEvent('QBCore:Server:OnMoneyChange', source, moneytype, amount, changeType, reason)

    if isRemoval and moneytype == 'bank' then
        TriggerClientEvent('qb-phone:client:RemoveBankMoney', source, amount)
    end
end

function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData = PlayerData or {}
    local Offline = not source

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
        PlayerData.license = PlayerData.license or GetPlayerIdentifierByType(source, 'license')
        PlayerData.name    = GetPlayerName(source)
    end

    if GetResourceState('qb-inventory') ~= 'missing' then
        PlayerData.items = exports['qb-inventory']:LoadInventory(PlayerData.source, PlayerData.citizenid)
    end

    return QBCore.Player.CreatePlayer(PlayerData, Offline)
end

local Player = {}
Player.__index = Player

-- Add/Edit Player Functions Below

-- Player Data Getters

function Player:GetName()
    local charinfo = self.PlayerData.charinfo
    return charinfo.firstname .. ' ' .. charinfo.lastname
end

function Player:GetMetaData(meta)
    if not meta or type(meta) ~= 'string' then return end
    return self.PlayerData.metadata[meta]
end

function Player:GetRep(rep)
    if not rep then return end
    return self.PlayerData.metadata['rep'][rep] or 0
end

function Player:GetMoney(moneytype)
    if not moneytype then return false end
    moneytype = moneytype:lower()
    return self.PlayerData.money[moneytype]
end

-- Job and Gang Functions

function Player:SetJobDuty(onDuty)
    if not self.PlayerData.job then return false end
    local newDuty = onDuty == true
    if self.PlayerData.job.onduty == newDuty then return false end
    self.PlayerData.job.onduty = newDuty
    self:UpdatePlayerData()
    TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
    TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
    return true
end

function Player:SetJob(job, grade)
    if type(job) ~= 'string' then return false end

    job = job:lower()
    grade = tostring(grade or '0')

    local jobData = QBCore.Shared.Jobs[job]
    local gradeData = jobData and jobData.grades[grade]

    if not jobData then return false end

    local jobInfo = {
        name = job,
        label = jobData.label,
        onduty = jobData.defaultDuty,
        type = jobData.type or 'none',
        grade = {
            name = gradeData and gradeData.name or 'No Grades',
            level = gradeData and tonumber(grade) or 0,
            payment = gradeData and gradeData.payment or 30,
            isboss = gradeData and (gradeData.isboss or false) or false
        },
        isboss = gradeData and (gradeData.isboss or false) or false
    }

    self.PlayerData.job = jobInfo

    if not self.Offline then
        self:UpdatePlayerData()
        TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, jobInfo)
        TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, jobInfo)
    end

    return true
end

function Player:SetGang(gang, grade)
    if type(gang) ~= 'string' then return false end

    gang = gang:lower()
    grade = tostring(grade or '0')

    local gangData = QBCore.Shared.Gangs[gang]
    local gradeData = gangData and gangData.grades[grade]

    if not gangData then return false end

    local gangInfo = {
        name = gang,
        label = gangData.label,
        grade = {
            name = gradeData and gradeData.name or 'No Grades',
            level = gradeData and tonumber(grade) or 0,
            isboss = gradeData and (gradeData.isboss or false) or false
        },
        isboss = gradeData and (gradeData.isboss or false) or false
    }

    self.PlayerData.gang = gangInfo

    if not self.Offline then
        self:UpdatePlayerData()
        TriggerEvent('QBCore:Server:OnGangUpdate', self.PlayerData.source, gangInfo)
        TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, gangInfo)
    end

    return true
end

-- Player Data Functions

function Player:SetPlayerData(key, val)
    if not key or type(key) ~= 'string' then return false end
    if self.PlayerData[key] == nil then return false end
    self.PlayerData[key] = val
    self:UpdatePlayerData()
    return true
end

function Player:SetMetaData(meta, val)
    if not meta or type(meta) ~= 'string' then return false end
    if self.PlayerData.metadata[meta] == nil then return false end
    if meta == 'hunger' or meta == 'thirst' then
        val = math.min(math.max(val, 0), 100)
    end
    self.PlayerData.metadata[meta] = val
    self:UpdatePlayerData()
    return true
end

-- Reputation Functions

function Player:AddRep(rep, amount)
    if not rep then return false end
    local addAmount = tonumber(amount) or 1
    local currentRep = self.PlayerData.metadata['rep'][rep] or 0
    self.PlayerData.metadata['rep'][rep] = currentRep + addAmount
    self:UpdatePlayerData()
    return true
end

function Player:RemoveRep(rep, amount)
    if not rep then return false end
    local removeAmount = tonumber(amount) or 1
    local currentRep = self.PlayerData.metadata['rep'][rep] or 0
    self.PlayerData.metadata['rep'][rep] = math.max(currentRep - removeAmount, 0)
    self:UpdatePlayerData()
    return true
end

function Player:SetRep(rep, amount)
    if not rep then return false end
    local setAmount = math.max(tonumber(amount) or 0, 0)
    self.PlayerData.metadata['rep'][rep] = setAmount
    self:UpdatePlayerData()
    return true
end

-- Money Functions

function Player:AddMoney(moneytype, amount, reason)
    reason = reason or 'unknown'
    moneytype = moneytype:lower()
    amount = tonumber(amount)
    if not amount or amount < 0 then return end
    if not self.PlayerData.money[moneytype] then return false end
    self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
    if not self.Offline then
        self:UpdatePlayerData()
        LogAndSyncMoneyChange(self, moneytype, amount, 'add', reason)
    end
    return true
end

function Player:RemoveMoney(moneytype, amount, reason)
    reason = reason or 'unknown'
    moneytype = moneytype:lower()
    amount = tonumber(amount)
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
        self:UpdatePlayerData()
        LogAndSyncMoneyChange(self, moneytype, amount, 'remove', reason)
    end
    return true
end

function Player:SetMoney(moneytype, amount, reason)
    reason = reason or 'unknown'
    moneytype = moneytype:lower()
    amount = tonumber(amount)
    if not amount or amount < 0 then return end
    if not self.PlayerData.money[moneytype] then return false end
    local difference = amount - self.PlayerData.money[moneytype]
    self.PlayerData.money[moneytype] = amount
    if not self.Offline then
        self:UpdatePlayerData()
        LogAndSyncMoneyChange(self, moneytype, amount, 'set', reason, difference)
    end
    return true
end

-- Utility Functions

function Player:Notify(text, type, length)
    TriggerClientEvent('QBCore:Notify', self.PlayerData.source, text, type, length)
end

function Player:AddMethod(methodName, handler)
    if Player[methodName] then
        return false
    end
    Player[methodName] = handler
    return true
end

function Player:AddField(fieldName, data)
    if Player[fieldName] then
        return false
    end
    Player[fieldName] = data
    return true
end

-- Player Handler Functions

function Player:UpdatePlayerData()
    if self.Offline then return end
    TriggerEvent('QBCore:Player:SetPlayerData', self.PlayerData)
    TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
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

function Player.new(PlayerData, Offline)
    local self = {
        PlayerData = PlayerData,
        Offline = Offline
    }
    return setmetatable(self, Player)
end

function QBCore.Player.CreatePlayer(PlayerData, Offline)
    local player = Player.new(PlayerData, Offline)
    QBCore.Debug(player)
    if not Offline then
        local src = PlayerData.source
        QBCore.Players[src] = player
        QBCore.Player.Save(src)
        TriggerEvent('QBCore:Server:PlayerLoaded', player)
        player:UpdatePlayerData()
    end
    return player
end

-- Save player info to database (make sure citizenid is the primary key in your database)

function QBCore.Player.Save(source)
    local ped = GetPlayerPed(source)
    local pcoords = GetEntityCoords(ped)
    local PlayerData = QBCore.Players[source].PlayerData
    if PlayerData then
        MySQL.insert('INSERT INTO players (citizenid, cid, license, name, money, charinfo, job, gang, position, metadata) VALUES (:citizenid, :cid, :license, :name, :money, :charinfo, :job, :gang, :position, :metadata) ON DUPLICATE KEY UPDATE cid = :cid, name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata', {
            citizenid = PlayerData.citizenid,
            cid = tonumber(PlayerData.cid),
            license = PlayerData.license,
            name = PlayerData.name,
            money = json.encode(PlayerData.money),
            charinfo = json.encode(PlayerData.charinfo),
            job = json.encode(PlayerData.job),
            gang = json.encode(PlayerData.gang),
            position = json.encode(pcoords),
            metadata = json.encode(PlayerData.metadata)
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
            cid = tonumber(PlayerData.cid),
            license = PlayerData.license,
            name = PlayerData.name,
            money = json.encode(PlayerData.money),
            charinfo = json.encode(PlayerData.charinfo),
            job = json.encode(PlayerData.job),
            gang = json.encode(PlayerData.gang),
            position = json.encode(PlayerData.position),
            metadata = json.encode(PlayerData.metadata)
        })
        if GetResourceState('qb-inventory') ~= 'missing' then exports['qb-inventory']:SaveInventory(PlayerData, true) end
        QBCore.ShowSuccess(resourceName, PlayerData.name .. ' OFFLINE PLAYER SAVED!')
    else
        QBCore.ShowError(resourceName, 'ERROR QBCORE.PLAYER.SAVEOFFLINE - PLAYERDATA IS EMPTY!')
    end
end

-- Delete character

local playertables = { -- Add tables as needed
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

function QBCore.Player.DeleteCharacter(source, citizenid, force)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local result = MySQL.scalar.await('SELECT license FROM players WHERE citizenid = ?', { citizenid })

    if force or (license == result) then
        local query = 'DELETE FROM %s WHERE citizenid = ?'
        local tableCount = #playertables
        local queries = table.create(tableCount, 0)

        local player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
        if force and player then
            DropPlayer(player.PlayerData.source, 'An admin deleted the character which you are currently using')
        end

        for i = 1, tableCount do
            local v = playertables[i]
            queries[i] = { query = query:format(v.table), values = { citizenid } }
        end

        MySQL.transaction(queries, function(result2)
            if result2 then
                if force then
                    TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Force Deleted', 'red', 'Character **' .. citizenid .. '** got deleted')
                else
                    TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Deleted', 'red', '**' .. GetPlayerName(source) .. '** ' .. license .. ' deleted **' .. citizenid .. '**..')
                end
            end
        end)
    else
        DropPlayer(source, Lang:t('info.exploit_dropped'))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' Has Been Dropped For Character Deletion Exploit', true)
    end
end

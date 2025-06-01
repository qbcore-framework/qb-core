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

function QBCore.Player.GetOfflinePlayer(citizenid)
    if not citizenid then return nil end
    local row = MySQL.prepare.await('SELECT * FROM players WHERE citizenid = ?', { citizenid })
    if not row then return nil end
    row.money    = json.decode(row.money) or {}
    row.job      = json.decode(row.job) or {}
    row.gang     = json.decode(row.gang) or {}
    row.position = json.decode(row.position) or {}
    row.metadata = json.decode(row.metadata) or {}
    row.charinfo = json.decode(row.charinfo) or {}
    return QBCore.Player.CheckPlayerData(nil, row)
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
            PlayerData.money = json.decode(PlayerData.money)
            PlayerData.job = json.decode(PlayerData.job)
            PlayerData.gang = json.decode(PlayerData.gang)
            PlayerData.position = json.decode(PlayerData.position)
            PlayerData.metadata = json.decode(PlayerData.metadata)
            PlayerData.charinfo = json.decode(PlayerData.charinfo)
            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
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

-- On player logout

function QBCore.Player.Logout(source)
    TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
    TriggerEvent('QBCore:Server:OnPlayerUnload', source)
    TriggerClientEvent('QBCore:Player:UpdatePlayerData', source)
    Wait(200)
    QBCore.Players[source] = nil
end

-- Create a new character
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.CreatePlayer(PlayerData, Offline)
    local self = {}
    self.Functions = {}
    self.PlayerData = PlayerData
    self.Offline = Offline

    function self.Functions.UpdatePlayerData()
        if self.Offline then return end
        TriggerEvent('QBCore:Player:SetPlayerData', self.PlayerData)
        TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
    end

    function self.Functions.SetJob(job, grade)
        job = job:lower()
        grade = grade or '0'
        if not QBCore.Shared.Jobs[job] then return false end
        self.PlayerData.job = {
            name = job,
            label = QBCore.Shared.Jobs[job].label,
            onduty = QBCore.Shared.Jobs[job].defaultDuty,
            type = QBCore.Shared.Jobs[job].type or 'none',
            grade = {
                name = 'No Grades',
                level = 0,
                payment = 30,
                isboss = false
            }
        }
        local gradeKey = tostring(grade)
        local jobGradeInfo = QBCore.Shared.Jobs[job].grades[gradeKey]
        if jobGradeInfo then
            self.PlayerData.job.grade.name = jobGradeInfo.name
            self.PlayerData.job.grade.level = tonumber(gradeKey)
            self.PlayerData.job.grade.payment = jobGradeInfo.payment
            self.PlayerData.job.grade.isboss = jobGradeInfo.isboss or false
            self.PlayerData.job.isboss = jobGradeInfo.isboss or false
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
            TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
        end

        return true
    end

    function self.Functions.SetGang(gang, grade)
        gang = gang:lower()
        grade = grade or '0'
        if not QBCore.Shared.Gangs[gang] then return false end
        self.PlayerData.gang = {
            name = gang,
            label = QBCore.Shared.Gangs[gang].label,
            grade = {
                name = 'No Grades',
                level = 0,
                isboss = false
            }
        }
        local gradeKey = tostring(grade)
        local gangGradeInfo = QBCore.Shared.Gangs[gang].grades[gradeKey]
        if gangGradeInfo then
            self.PlayerData.gang.grade.name = gangGradeInfo.name
            self.PlayerData.gang.grade.level = tonumber(gradeKey)
            self.PlayerData.gang.grade.isboss = gangGradeInfo.isboss or false
            self.PlayerData.gang.isboss = gangGradeInfo.isboss or false
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('QBCore:Server:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
            TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
        end

        return true
    end

    function self.Functions.Notify(text, type, length)
        TriggerClientEvent('QBCore:Notify', self.PlayerData.source, text, type, length)
    end

    function self.Functions.HasItem(items, amount)
        return QBCore.Functions.HasItem(self.PlayerData.source, items, amount)
    end

    function self.Functions.GetName()
        local charinfo = self.PlayerData.charinfo
        return charinfo.firstname .. ' ' .. charinfo.lastname
    end

    function self.Functions.SetJobDuty(onDuty)
        self.PlayerData.job.onduty = not not onDuty
        TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
        TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetPlayerData(key, val)
        if not key or type(key) ~= 'string' then return end
        self.PlayerData[key] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetMetaData(meta, val)
        if not meta or type(meta) ~= 'string' then return end
        if meta == 'hunger' or meta == 'thirst' then
            val = val > 100 and 100 or val
        end
        self.PlayerData.metadata[meta] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.GetMetaData(meta)
        if not meta or type(meta) ~= 'string' then return end
        return self.PlayerData.metadata[meta]
    end

    function self.Functions.AddRep(rep, amount)
        if not rep or not amount then return end
        local addAmount = tonumber(amount)
        local currentRep = self.PlayerData.metadata['rep'][rep] or 0
        self.PlayerData.metadata['rep'][rep] = currentRep + addAmount
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.RemoveRep(rep, amount)
        if not rep or not amount then return end
        local removeAmount = tonumber(amount)
        local currentRep = self.PlayerData.metadata['rep'][rep] or 0
        if currentRep - removeAmount < 0 then
            self.PlayerData.metadata['rep'][rep] = 0
        else
            self.PlayerData.metadata['rep'][rep] = currentRep - removeAmount
        end
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.GetRep(rep)
        if not rep then return end
        return self.PlayerData.metadata['rep'][rep] or 0
    end

    function self.Functions.AddMoney(moneytype, amount, reason)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then return end
        if not self.PlayerData.money[moneytype] then return false end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason, true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason)
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false)
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'add', reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'add', reason)
        end

        return true
    end

    function self.Functions.RemoveMoney(moneytype, amount, reason)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then return end
        if not self.PlayerData.money[moneytype] then return false end
        for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
            if mtype == moneytype then
                if (self.PlayerData.money[moneytype] - amount) < 0 then
                    return false
                end
            end
        end
        if self.PlayerData.money[moneytype] - amount < QBCore.Config.Money.MinusLimit then return false end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason, true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason)
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true)
            if moneytype == 'bank' then
                TriggerClientEvent('qb-phone:client:RemoveBankMoney', self.PlayerData.source, amount)
            end
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'remove', reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'remove', reason)
        end

        return true
    end

    function self.Functions.SetMoney(moneytype, amount, reason)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then return false end
        if not self.PlayerData.money[moneytype] then return false end
        local difference = amount - self.PlayerData.money[moneytype]
        self.PlayerData.money[moneytype] = amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'SetMoney', 'green', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') set, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason)
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, math.abs(difference), difference < 0)
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'set', reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, 'set', reason)
        end

        return true
    end

    function self.Functions.GetMoney(moneytype)
        if not moneytype then return false end
        moneytype = moneytype:lower()
        return self.PlayerData.money[moneytype]
    end

    function self.Functions.Save()
        if self.Offline then
            QBCore.Player.SaveOffline(self.PlayerData)
        else
            QBCore.Player.Save(self.PlayerData.source)
        end
    end

    function self.Functions.Logout()
        if self.Offline then return end
        QBCore.Player.Logout(self.PlayerData.source)
    end

    function self.Functions.AddMethod(methodName, handler)
        self.Functions[methodName] = handler
    end

    function self.Functions.AddField(fieldName, data)
        self[fieldName] = data
    end

    if self.Offline then
        return self
    else
        QBCore.Players[self.PlayerData.source] = self
        QBCore.Player.Save(self.PlayerData.source)
        TriggerEvent('QBCore:Server:PlayerLoaded', self)
        self.Functions.UpdatePlayerData()
    end
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

function QBCore.Player.DeleteCharacter(source, citizenid)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local result = MySQL.scalar.await('SELECT license FROM players where citizenid = ?', { citizenid })
    if license == result then
        local query = 'DELETE FROM %s WHERE citizenid = ?'
        local tableCount = #playertables
        local queries = table.create(tableCount, 0)

        for i = 1, tableCount do
            local v = playertables[i]
            queries[i] = { query = query:format(v.table), values = { citizenid } }
        end

        MySQL.transaction(queries, function(result2)
            if result2 then
                TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Deleted', 'red', '**' .. GetPlayerName(source) .. '** ' .. license .. ' deleted **' .. citizenid .. '**..')
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
        local query = 'DELETE FROM %s WHERE citizenid = ?'
        local tableCount = #playertables
        local queries = table.create(tableCount, 0)
        local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)

        if Player then
            DropPlayer(Player.PlayerData.source, 'An admin deleted the character which you are currently using')
        end
        for i = 1, tableCount do
            local v = playertables[i]
            queries[i] = { query = query:format(v.table), values = { citizenid } }
        end

        MySQL.transaction(queries, function(result2)
            if result2 then
                TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Force Deleted', 'red', 'Character **' .. citizenid .. '** got deleted')
            end
        end)
    end
end

-- Inventory Backwards Compatibility

function QBCore.Player.SaveInventory(source)
    if GetResourceState('qb-inventory') == 'missing' then return end
    exports['qb-inventory']:SaveInventory(source, false)
end

function QBCore.Player.SaveOfflineInventory(PlayerData)
    if GetResourceState('qb-inventory') == 'missing' then return end
    exports['qb-inventory']:SaveInventory(PlayerData, true)
end

function QBCore.Player.GetTotalWeight(items)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetTotalWeight(items)
end

function QBCore.Player.GetSlotsByItem(items, itemName)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetSlotsByItem(items, itemName)
end

function QBCore.Player.GetFirstSlotByItem(items, itemName)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetFirstSlotByItem(items, itemName)
end

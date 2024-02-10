QBCore.Players = {}
QBCore.Player = {}

-- On player login get their data or set defaults
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

local resourceName = GetCurrentResourceName()
function QBCore.Player.Login(source, citizenid, newData)
    if source and source ~= '' then
        if citizenid then
            local license = QBCore.Functions.GetIdentifier(source, 'license')
            local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
            if PlayerData and license == PlayerData.license then
                PlayerData.money = json.decode(PlayerData.money)
                PlayerData.job = json.decode(PlayerData.job)
                PlayerData.position = json.decode(PlayerData.position)
                PlayerData.metadata = json.decode(PlayerData.metadata)
                PlayerData.charinfo = json.decode(PlayerData.charinfo)
                if PlayerData.gang then
                    PlayerData.gang = json.decode(PlayerData.gang)
                else
                    PlayerData.gang = {}
                end
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

function QBCore.Player.GetOfflinePlayer(citizenid)
    if citizenid then
        local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
        if PlayerData then
            PlayerData.money = json.decode(PlayerData.money)
            PlayerData.job = json.decode(PlayerData.job)
            PlayerData.position = json.decode(PlayerData.position)
            PlayerData.metadata = json.decode(PlayerData.metadata)
            PlayerData.charinfo = json.decode(PlayerData.charinfo)
            if PlayerData.gang then
                PlayerData.gang = json.decode(PlayerData.gang)
            else
                PlayerData.gang = {}
            end

            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
end

function QBCore.Player.GetPlayerByLicense(license)
    if license then
        local PlayerData = MySQL.prepare.await('SELECT * FROM players where license = ?', { license })
        if PlayerData then
            PlayerData.money = json.decode(PlayerData.money)
            PlayerData.job = json.decode(PlayerData.job)
            PlayerData.position = json.decode(PlayerData.position)
            PlayerData.metadata = json.decode(PlayerData.metadata)
            PlayerData.charinfo = json.decode(PlayerData.charinfo)
            if PlayerData.gang then
                PlayerData.gang = json.decode(PlayerData.gang)
            else
                PlayerData.gang = {}
            end

            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
end

function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData = PlayerData or {}
    local Offline = true
    if source then
        PlayerData.source = source
        PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(source, 'license')
        PlayerData.name = GetPlayerName(source)
        Offline = false
    end

    PlayerData.citizenid = PlayerData.citizenid or QBCore.Player.CreateCitizenId()
    PlayerData.cid = PlayerData.cid or 1
    PlayerData.money = PlayerData.money or {}
    PlayerData.optin = PlayerData.optin or true
    for moneytype, startamount in pairs(QBCore.Config.Money.MoneyTypes) do
        PlayerData.money[moneytype] = PlayerData.money[moneytype] or startamount
    end

    -- Charinfo
    PlayerData.charinfo = PlayerData.charinfo or {}
    PlayerData.charinfo.firstname = PlayerData.charinfo.firstname or 'Firstname'
    PlayerData.charinfo.lastname = PlayerData.charinfo.lastname or 'Lastname'
    PlayerData.charinfo.birthdate = PlayerData.charinfo.birthdate or '00-00-0000'
    PlayerData.charinfo.gender = PlayerData.charinfo.gender or 0
    PlayerData.charinfo.backstory = PlayerData.charinfo.backstory or 'placeholder backstory'
    PlayerData.charinfo.nationality = PlayerData.charinfo.nationality or 'USA'
    PlayerData.charinfo.phone = PlayerData.charinfo.phone or QBCore.Functions.CreatePhoneNumber()
    PlayerData.charinfo.account = PlayerData.charinfo.account or QBCore.Functions.CreateAccountNumber()
    -- Metadata
    PlayerData.metadata = PlayerData.metadata or {}
    PlayerData.metadata['hunger'] = PlayerData.metadata['hunger'] or 100
    PlayerData.metadata['thirst'] = PlayerData.metadata['thirst'] or 100
    PlayerData.metadata['stress'] = PlayerData.metadata['stress'] or 0
    PlayerData.metadata['isdead'] = PlayerData.metadata['isdead'] or false
    PlayerData.metadata['inlaststand'] = PlayerData.metadata['inlaststand'] or false
    PlayerData.metadata['armor'] = PlayerData.metadata['armor'] or 0
    PlayerData.metadata['ishandcuffed'] = PlayerData.metadata['ishandcuffed'] or false
    PlayerData.metadata['tracker'] = PlayerData.metadata['tracker'] or false
    PlayerData.metadata['injail'] = PlayerData.metadata['injail'] or 0
    PlayerData.metadata['jailitems'] = PlayerData.metadata['jailitems'] or {}
    PlayerData.metadata['status'] = PlayerData.metadata['status'] or {}
    PlayerData.metadata['phone'] = PlayerData.metadata['phone'] or {}
    PlayerData.metadata['fitbit'] = PlayerData.metadata['fitbit'] or {}
    PlayerData.metadata['bloodtype'] = PlayerData.metadata['bloodtype'] or QBCore.Config.Player.Bloodtypes[math.random(1, #QBCore.Config.Player.Bloodtypes)]
    PlayerData.metadata['dealerrep'] = PlayerData.metadata['dealerrep'] or 0
    PlayerData.metadata['craftingrep'] = PlayerData.metadata['craftingrep'] or 0
    PlayerData.metadata['attachmentcraftingrep'] = PlayerData.metadata['attachmentcraftingrep'] or 0
    PlayerData.metadata['currentapartment'] = PlayerData.metadata['currentapartment'] or nil
    PlayerData.metadata['jobrep'] = PlayerData.metadata['jobrep'] or {}
    PlayerData.metadata['jobrep']['tow'] = PlayerData.metadata['jobrep']['tow'] or 0
    PlayerData.metadata['jobrep']['trucker'] = PlayerData.metadata['jobrep']['trucker'] or 0
    PlayerData.metadata['jobrep']['taxi'] = PlayerData.metadata['jobrep']['taxi'] or 0
    PlayerData.metadata['jobrep']['hotdog'] = PlayerData.metadata['jobrep']['hotdog'] or 0
    PlayerData.metadata['callsign'] = PlayerData.metadata['callsign'] or 'NO CALLSIGN'
    PlayerData.metadata['fingerprint'] = PlayerData.metadata['fingerprint'] or QBCore.Player.CreateFingerId()
    PlayerData.metadata['walletid'] = PlayerData.metadata['walletid'] or QBCore.Player.CreateWalletId()
    PlayerData.metadata['criminalrecord'] = PlayerData.metadata['criminalrecord'] or {
        ['hasRecord'] = false,
        ['date'] = nil
    }
    PlayerData.metadata['licences'] = PlayerData.metadata['licences'] or {
        ['driver'] = true,
        ['business'] = false,
        ['weapon'] = false
    }
    PlayerData.metadata['inside'] = PlayerData.metadata['inside'] or {
        house = nil,
        apartment = {
            apartmentType = nil,
            apartmentId = nil,
        }
    }
    PlayerData.metadata['phonedata'] = PlayerData.metadata['phonedata'] or {
        SerialNumber = QBCore.Player.CreateSerialNumber(),
        InstalledApps = {},
    }
    -- Job
    if PlayerData.job and PlayerData.job.name and not QBCore.Shared.Jobs[PlayerData.job.name] then PlayerData.job = nil end
    PlayerData.job = PlayerData.job or {}
    PlayerData.job.name = PlayerData.job.name or 'unemployed'
    PlayerData.job.label = PlayerData.job.label or 'Civilian'
    PlayerData.job.payment = PlayerData.job.payment or 10
    PlayerData.job.type = PlayerData.job.type or 'none'
    if QBCore.Shared.ForceJobDefaultDutyAtLogin or PlayerData.job.onduty == nil then
        PlayerData.job.onduty = QBCore.Shared.Jobs[PlayerData.job.name].defaultDuty
    end
    PlayerData.job.isboss = PlayerData.job.isboss or false
    PlayerData.job.grade = PlayerData.job.grade or {}
    PlayerData.job.grade.name = PlayerData.job.grade.name or 'Freelancer'
    PlayerData.job.grade.level = PlayerData.job.grade.level or 0
    -- Gang
    if PlayerData.gang and PlayerData.gang.name and not QBCore.Shared.Gangs[PlayerData.gang.name] then PlayerData.gang = nil end
    PlayerData.gang = PlayerData.gang or {}
    PlayerData.gang.name = PlayerData.gang.name or 'none'
    PlayerData.gang.label = PlayerData.gang.label or 'No Gang Affiliaton'
    PlayerData.gang.isboss = PlayerData.gang.isboss or false
    PlayerData.gang.grade = PlayerData.gang.grade or {}
    PlayerData.gang.grade.name = PlayerData.gang.grade.name or 'none'
    PlayerData.gang.grade.level = PlayerData.gang.grade.level or 0
    -- Other
    PlayerData.position = PlayerData.position or QBCore.Config.DefaultSpawn
    PlayerData.items = GetResourceState('qb-inventory') ~= 'missing' and exports['qb-inventory']:LoadInventory(PlayerData.source, PlayerData.citizenid) or {}
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
        if self.Offline then return end -- Unsupported for Offline Players
        TriggerEvent('QBCore:Player:SetPlayerData', self.PlayerData)
        TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
    end

    function self.Functions.SetJob(job, grade)
        job = job:lower()
        grade = tostring(grade) or '0'
        if not QBCore.Shared.Jobs[job] then return false end
        self.PlayerData.job.name = job
        self.PlayerData.job.label = QBCore.Shared.Jobs[job].label
        self.PlayerData.job.onduty = QBCore.Shared.Jobs[job].defaultDuty
        self.PlayerData.job.type = QBCore.Shared.Jobs[job].type or 'none'
        if QBCore.Shared.Jobs[job].grades[grade] then
            local jobgrade = QBCore.Shared.Jobs[job].grades[grade]
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = jobgrade.name
            self.PlayerData.job.grade.level = tonumber(grade)
            self.PlayerData.job.payment = jobgrade.payment or 30
            self.PlayerData.job.isboss = jobgrade.isboss or false
        else
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = 'No Grades'
            self.PlayerData.job.grade.level = 0
            self.PlayerData.job.payment = 30
            self.PlayerData.job.isboss = false
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
        grade = tostring(grade) or '0'
        if not QBCore.Shared.Gangs[gang] then return false end
        self.PlayerData.gang.name = gang
        self.PlayerData.gang.label = QBCore.Shared.Gangs[gang].label
        if QBCore.Shared.Gangs[gang].grades[grade] then
            local ganggrade = QBCore.Shared.Gangs[gang].grades[grade]
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = ganggrade.name
            self.PlayerData.gang.grade.level = tonumber(grade)
            self.PlayerData.gang.isboss = ganggrade.isboss or false
        else
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = 'No Grades'
            self.PlayerData.gang.grade.level = 0
            self.PlayerData.gang.isboss = false
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('QBCore:Server:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
            TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
        end

        return true
    end

    function self.Functions.Notify(text, type, lenght)
        TriggerClientEvent('QBCore:Notify', self.PlayerData.source, text, type, lenght)
    end

    function self.Functions.HasItem(items, amount)
        QBCore.Functions.HasItem(self.PlayerData.source, items, amount)
    end

    function self.Functions.SetJobDuty(onDuty)
        self.PlayerData.job.onduty = not not onDuty -- Make sure the value is a boolean if nil is sent
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

    function self.Functions.AddJobReputation(amount)
        if not amount then return end
        amount = tonumber(amount)
        self.PlayerData.metadata['jobrep'][self.PlayerData.job.name] = self.PlayerData.metadata['jobrep'][self.PlayerData.job.name] + amount
        self.Functions.UpdatePlayerData()
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

    function self.Functions.SetCreditCard(cardNumber)
        self.PlayerData.charinfo.card = cardNumber
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.GetCardSlot(cardNumber, cardType)
        local item = tostring(cardType):lower()
        local slots = exports['qb-inventory']:GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                if self.PlayerData.items[slot].info.cardNumber == cardNumber then
                    return slot
                end
            end
        end
        return nil
    end

    function self.Functions.Save()
        if self.Offline then
            QBCore.Player.SaveOffline(self.PlayerData)
        else
            QBCore.Player.Save(self.PlayerData.source)
        end
    end

    function self.Functions.Logout()
        if self.Offline then return end -- Unsupported for Offline Players
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

        -- At this point we are safe to emit new instance to third party resource for load handling
        TriggerEvent('QBCore:Server:PlayerLoaded', self)
        self.Functions.UpdatePlayerData()
    end
end

-- Add a new function to the Functions table of the player class
-- Use-case:
--[[
    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
        QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "functionName", function(oneArg, orMore)
            -- do something here
        end)
    end)
]]

function QBCore.Functions.AddPlayerMethod(ids, methodName, handler)
    local idType = type(ids)
    if idType == 'number' then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddMethod(methodName, handler)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddMethod(methodName, handler)
        end
    elseif idType == 'table' and table.type(ids) == 'array' then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerMethod(ids[i], methodName, handler)
        end
    end
end

-- Add a new field table of the player class
-- Use-case:
--[[
    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
        QBCore.Functions.AddPlayerField(Player.PlayerData.source, "fieldName", "fieldData")
    end)
]]

function QBCore.Functions.AddPlayerField(ids, fieldName, data)
    local idType = type(ids)
    if idType == 'number' then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddField(fieldName, data)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddField(fieldName, data)
        end
    elseif idType == 'table' and table.type(ids) == 'array' then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerField(ids[i], fieldName, data)
        end
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
        MySQL.Async.insert('INSERT INTO players (citizenid, cid, license, name, money, charinfo, job, gang, position, metadata) VALUES (:citizenid, :cid, :license, :name, :money, :charinfo, :job, :gang, :position, :metadata) ON DUPLICATE KEY UPDATE cid = :cid, name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata', {
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

-- Util Functions

function QBCore.Player.CreateCitizenId()
    local UniqueFound = false
    local CitizenId = nil
    while not UniqueFound do
        CitizenId = tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(5)):upper()
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE citizenid = ?', { CitizenId })
        if result == 0 then
            UniqueFound = true
        end
    end
    return CitizenId
end

function QBCore.Functions.CreateAccountNumber()
    local UniqueFound = false
    local AccountNumber = nil
    while not UniqueFound do
        AccountNumber = 'US0' .. math.random(1, 9) .. 'QBCore' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
        local query = '%' .. AccountNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return AccountNumber
end

function QBCore.Functions.CreatePhoneNumber()
    local UniqueFound = false
    local PhoneNumber = nil
    while not UniqueFound do
        PhoneNumber = math.random(100, 999) .. math.random(1000000, 9999999)
        local query = '%' .. PhoneNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return PhoneNumber
end

function QBCore.Player.CreateFingerId()
    local UniqueFound = false
    local FingerId = nil
    while not UniqueFound do
        FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
        local query = '%' .. FingerId .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return FingerId
end

function QBCore.Player.CreateWalletId()
    local UniqueFound = false
    local WalletId = nil
    while not UniqueFound do
        WalletId = 'QB-' .. math.random(11111111, 99999999)
        local query = '%' .. WalletId .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return WalletId
end

function QBCore.Player.CreateSerialNumber()
    local UniqueFound = false
    local SerialNumber = nil
    while not UniqueFound do
        SerialNumber = math.random(11111111, 99999999)
        local query = '%' .. SerialNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return SerialNumber
end

PaycheckInterval() -- This starts the paycheck system

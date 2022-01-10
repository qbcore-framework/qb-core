QBCore.Players = {}
QBCore.Player = {}

-- On player login get their data or set defaults
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.Login(source, citizenid, newData)
    local src = source
    if src then
        if citizenid then
            local license = QBCore.Functions.GetIdentifier(src, 'license')
            local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where citizenid = ?', { citizenid })
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
                QBCore.Player.CheckPlayerData(src, PlayerData)
            else
                DropPlayer(src, 'You Have Been Kicked For Exploitation')
                TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(src) .. ' Has Been Dropped For Character Joining Exploit', false)
            end
        else
            QBCore.Player.CheckPlayerData(src, newData)
        end
        return true
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!')
        return false
    end
end

function QBCore.Player.CheckPlayerData(source, PlayerData)
    local src = source
    PlayerData = PlayerData or {}
    PlayerData.source = src
    PlayerData.citizenid = PlayerData.citizenid or QBCore.Player.CreateCitizenId()
    PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(src, 'license')
    PlayerData.name = GetPlayerName(src)
    PlayerData.cid = PlayerData.cid or 1
    PlayerData.money = PlayerData.money or {}
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
    PlayerData.charinfo.phone = PlayerData.charinfo.phone ~= nil and PlayerData.charinfo.phone or '1' .. math.random(111111111, 999999999)
    PlayerData.charinfo.account = PlayerData.charinfo.account ~= nil and PlayerData.charinfo.account or 'US0' .. math.random(1, 9) .. 'QBCore' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
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
    PlayerData.metadata['commandbinds'] = PlayerData.metadata['commandbinds'] or {}
    PlayerData.metadata['bloodtype'] = PlayerData.metadata['bloodtype'] or QBCore.Config.Player.Bloodtypes[math.random(1, #QBCore.Config.Player.Bloodtypes)]
    PlayerData.metadata['dealerrep'] = PlayerData.metadata['dealerrep'] or 0
    PlayerData.metadata['craftingrep'] = PlayerData.metadata['craftingrep'] or 0
    PlayerData.metadata['attachmentcraftingrep'] = PlayerData.metadata['attachmentcraftingrep'] or 0
    PlayerData.metadata['currentapartment'] = PlayerData.metadata['currentapartment'] or nil
    if PlayerData.metadata['jobrep'] ~= nil then
		PlayerData.metadata['jobrep'] = {
			['tow'] = PlayerData.metadata['jobrep']['tow'] or 0,
			['trucker'] = PlayerData.metadata['jobrep']['trucker'] or 0,
			['taxi'] = PlayerData.metadata['jobrep']['taxi'] or 0,
			['hotdog'] = PlayerData.metadata['jobrep']['hotdog'] or 0,
		}
	else
		PlayerData.metadata['jobrep'] = {
			['tow'] = 0,
			['trucker'] = 0,
			['taxi'] = 0,
			['hotdog'] = 0,
		}
	end
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
    PlayerData.job = PlayerData.job or {}
    PlayerData.job.name = PlayerData.job.name or 'unemployed'
    PlayerData.job.label = PlayerData.job.label or 'Civilian'
    PlayerData.job.payment = PlayerData.job.payment or 10
    if QBCore.Shared.ForceJobDefaultDutyAtLogin or PlayerData.job.onduty == nil then
        PlayerData.job.onduty = QBCore.Shared.Jobs[PlayerData.job.name].defaultDuty
    end
    PlayerData.job.isboss = PlayerData.job.isboss or false
    PlayerData.job.grade = PlayerData.job.grade or {}
    PlayerData.job.grade.name = PlayerData.job.grade.name or 'Freelancer'
    PlayerData.job.grade.level = PlayerData.job.grade.level or 0
    -- Gang
    PlayerData.gang = PlayerData.gang or {}
    PlayerData.gang.name = PlayerData.gang.name or 'none'
    PlayerData.gang.label = PlayerData.gang.label or 'No Gang Affiliaton'
    PlayerData.gang.isboss = PlayerData.gang.isboss or false
    PlayerData.gang.grade = PlayerData.gang.grade or {}
    PlayerData.gang.grade.name = PlayerData.gang.grade.name or 'none'
    PlayerData.gang.grade.level = PlayerData.gang.grade.level or 0
    -- Other
    PlayerData.position = PlayerData.position or QBConfig.DefaultSpawn
    PlayerData.LoggedIn = true
    PlayerData = QBCore.Player.LoadInventory(PlayerData)
    QBCore.Player.CreatePlayer(PlayerData)
end

-- On player logout

function QBCore.Player.Logout(source)
    local src = source
    TriggerClientEvent('QBCore:Client:OnPlayerUnload', src)
    TriggerClientEvent('QBCore:Player:UpdatePlayerData', src)
    Wait(200)
    QBCore.Players[src] = nil
end

-- Create a new character
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.CreatePlayer(PlayerData)
    local self = {}
    self.Functions = {}
    self.PlayerData = PlayerData

    self.Functions.UpdatePlayerData = function(dontUpdateChat)
        TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
        if dontUpdateChat == nil then
            QBCore.Commands.Refresh(self.PlayerData.source)
        end
    end

    self.Functions.SetJob = function(job, grade)
        local job = job:lower()
        local grade = tostring(grade) or '0'

        if QBCore.Shared.Jobs[job] then
            self.PlayerData.job.name = job
            self.PlayerData.job.label = QBCore.Shared.Jobs[job].label
            self.PlayerData.job.onduty = QBCore.Shared.Jobs[job].defaultDuty

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

            self.Functions.UpdatePlayerData()
            TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
            return true
        end

        return false
    end

    self.Functions.SetGang = function(gang, grade)
        local gang = gang:lower()
        local grade = tostring(grade) or '0'

        if QBCore.Shared.Gangs[gang] then
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

            self.Functions.UpdatePlayerData()
            TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
            return true
        end
        return false
    end

    self.Functions.SetJobDuty = function(onDuty)
        self.PlayerData.job.onduty = onDuty
        self.Functions.UpdatePlayerData()
    end

    self.Functions.SetMetaData = function(meta, val)
        local meta = meta:lower()
        if val ~= nil then
            self.PlayerData.metadata[meta] = val
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.AddJobReputation = function(amount)
        local amount = tonumber(amount)
        self.PlayerData.metadata['jobrep'][self.PlayerData.job.name] = self.PlayerData.metadata['jobrep'][self.PlayerData.job.name] + amount
        self.Functions.UpdatePlayerData()
    end

    self.Functions.AddMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false)
            return true
        end
        return false
    end

    self.Functions.RemoveMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
                if mtype == moneytype then
                    if self.PlayerData.money[moneytype] - amount < 0 then
                        return false
                    end
                end
            end
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true)
            if moneytype == 'bank' then
                TriggerClientEvent('qb-phone:client:RemoveBankMoney', self.PlayerData.source, amount)
            end
            return true
        end
        return false
    end

    self.Functions.SetMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            self.PlayerData.money[moneytype] = amount
            self.Functions.UpdatePlayerData()
            TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'SetMoney', 'green', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') set, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            return true
        end
        return false
    end

    self.Functions.GetMoney = function(moneytype)
        if moneytype then
            local moneytype = moneytype:lower()
            return self.PlayerData.money[moneytype]
        end
        return false
    end

    self.Functions.AddItem = function(item, amount, slot, info)
        local totalWeight = QBCore.Player.GetTotalWeight(self.PlayerData.items)
        local itemInfo = QBCore.Shared.Items[item:lower()]
        if itemInfo == nil then
            TriggerClientEvent('QBCore:Notify', self.PlayerData.source, Lang:t('error.item_not_exist'), 'error')
            return
        end
        local amount = tonumber(amount)
        local slot = tonumber(slot) or QBCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)
        if itemInfo['type'] == 'weapon' and info == nil then
            info = {
                serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)),
            }
        end
        if (totalWeight + (itemInfo['weight'] * amount)) <= QBCore.Config.Player.MaxWeight then
            if (slot and self.PlayerData.items[slot]) and (self.PlayerData.items[slot].name:lower() == item:lower()) and (itemInfo['type'] == 'item' and not itemInfo['unique']) then
                self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount + amount
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** got item: [slot:' .. slot .. '], itemname: ' .. self.PlayerData.items[slot].name .. ', added amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[slot].amount)
                return true
            elseif (not itemInfo['unique'] and slot or slot and self.PlayerData.items[slot] == nil) then
                self.PlayerData.items[slot] = { name = itemInfo['name'], amount = amount, info = info or '', label = itemInfo['label'], description = itemInfo['description'] or '', weight = itemInfo['weight'], type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = slot, combinable = itemInfo['combinable'] }
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** got item: [slot:' .. slot .. '], itemname: ' .. self.PlayerData.items[slot].name .. ', added amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[slot].amount)
                return true
            elseif (itemInfo['unique']) or (not slot or slot == nil) or (itemInfo['type'] == 'weapon') then
                for i = 1, QBConfig.Player.MaxInvSlots, 1 do
                    if self.PlayerData.items[i] == nil then
                        self.PlayerData.items[i] = { name = itemInfo['name'], amount = amount, info = info or '', label = itemInfo['label'], description = itemInfo['description'] or '', weight = itemInfo['weight'], type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = i, combinable = itemInfo['combinable'] }
                        self.Functions.UpdatePlayerData()
                        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** got item: [slot:' .. i .. '], itemname: ' .. self.PlayerData.items[i].name .. ', added amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[i].amount)
                        return true
                    end
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', self.PlayerData.source, Lang:t('error.too_heavy'), 'error')
        end
        return false
    end

    self.Functions.RemoveItem = function(item, amount, slot)
        local amount = tonumber(amount)
        local slot = tonumber(slot)
        if slot then
            if self.PlayerData.items[slot].amount > amount then
                self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amount
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. self.PlayerData.items[slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[slot].amount)
                return true
            elseif self.PlayerData.items[slot].amount == amount then
                self.PlayerData.items[slot] = nil
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')
                return true
            end
        else
            local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
            local amountToRemove = amount
            if slots then
                for _, slot in pairs(slots) do
                    if self.PlayerData.items[slot].amount > amountToRemove then
                        self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amountToRemove
                        self.Functions.UpdatePlayerData()
                        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. self.PlayerData.items[slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[slot].amount)
                        return true
                    elseif self.PlayerData.items[slot].amount == amountToRemove then
                        self.PlayerData.items[slot] = nil
                        self.Functions.UpdatePlayerData()
                        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')
                        return true
                    end
                end
            end
        end
        return false
    end

    self.Functions.SetInventory = function(items, dontUpdateChat)
        self.PlayerData.items = items
        self.Functions.UpdatePlayerData(dontUpdateChat)
        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'SetInventory', 'blue', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** items set: ' .. json.encode(items))
    end

    self.Functions.ClearInventory = function()
        self.PlayerData.items = {}
        self.Functions.UpdatePlayerData()
        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'ClearInventory', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** inventory cleared')
    end

    self.Functions.GetItemByName = function(item)
        local item = tostring(item):lower()
        local slot = QBCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)
        if slot then
            return self.PlayerData.items[slot]
        end
        return nil
    end

    self.Functions.GetItemsByName = function(item)
        local item = tostring(item):lower()
        local items = {}
        local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                items[#items+1] = self.PlayerData.items[slot]
            end
        end
        return items
    end

    self.Functions.SetCreditCard = function(cardNumber)
        self.PlayerData.charinfo.card = cardNumber
        self.Functions.UpdatePlayerData()
    end

    self.Functions.GetCardSlot = function(cardNumber, cardType)
        local item = tostring(cardType):lower()
        local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                if self.PlayerData.items[slot].info.cardNumber == cardNumber then
                    return slot
                end
            end
        end
        return nil
    end

    self.Functions.GetItemBySlot = function(slot)
        local slot = tonumber(slot)
        if self.PlayerData.items[slot] then
            return self.PlayerData.items[slot]
        end
        return nil
    end

    self.Functions.Save = function()
        QBCore.Player.Save(self.PlayerData.source)
    end

    QBCore.Players[self.PlayerData.source] = self
    QBCore.Player.Save(self.PlayerData.source)

    -- At this point we are safe to emit new instance to third party resource for load handling
    TriggerEvent('QBCore:Server:PlayerLoaded', self)
    self.Functions.UpdatePlayerData()
end

-- Save player info to database (make sure citizenid is the primary key in your database)

function QBCore.Player.Save(source)
    local src = source
    local ped = GetPlayerPed(src)
    local pcoords = GetEntityCoords(ped)
    local PlayerData = QBCore.Players[src].PlayerData
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
            position = json.encode(pcoords),
            metadata = json.encode(PlayerData.metadata)
        })
        QBCore.Player.SaveInventory(src)
        QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.name .. ' PLAYER SAVED!')
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.SAVE - PLAYERDATA IS EMPTY!')
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
    { table = 'player_boats' },
    { table = 'player_contacts' },
    { table = 'player_houses' },
    { table = 'player_mails' },
    { table = 'player_outfits' },
    { table = 'player_vehicles' }
}

function QBCore.Player.DeleteCharacter(source, citizenid)
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local result = MySQL.Sync.fetchScalar('SELECT license FROM players where citizenid = ?', { citizenid })
    if license == result then
        local query = "DELETE FROM %s WHERE citizenid = ?"
		local tableCount = #playertables
		local queries = table.create(tableCount, 0)

		for i=1, tableCount do
			local v = playertables[i]
			queries[i] = {query = query:format(v.table), values = { citizenid }}
		end

        MySQL.Async.transaction(queries, function(result)
			if result then
				TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Deleted', 'red', '**' .. GetPlayerName(src) .. '** ' .. license .. ' deleted **' .. citizenid .. '**..')
            end
		end)
    else
        DropPlayer(src, 'You Have Been Kicked For Exploitation')
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(src) .. ' Has Been Dropped For Character Deletion Exploit', false)
    end
end

-- Inventory

QBCore.Player.LoadInventory = function(PlayerData)
    PlayerData.items = {}
    local inventory = MySQL.Sync.prepare('SELECT inventory FROM players WHERE citizenid = ?', { PlayerData.citizenid })
    if inventory then
        inventory = json.decode(inventory)
        if next(inventory) then
            for _, item in pairs(inventory) do
                if item then
                    local itemInfo = QBCore.Shared.Items[item.name:lower()]
                    if itemInfo then
                        PlayerData.items[item.slot] = {
                            name = itemInfo['name'],
                            amount = item.amount,
                            info = item.info or '',
                            label = itemInfo['label'],
                            description = itemInfo['description'] or '',
                            weight = itemInfo['weight'],
                            type = itemInfo['type'],
                            unique = itemInfo['unique'],
                            useable = itemInfo['useable'],
                            image = itemInfo['image'],
                            shouldClose = itemInfo['shouldClose'],
                            slot = item.slot,
                            combinable = itemInfo['combinable']
                        }
                    end
                end
            end
        end
    end
    return PlayerData
end

QBCore.Player.SaveInventory = function(source)
    local src = source
    if QBCore.Players[src] then
        local PlayerData = QBCore.Players[src].PlayerData
        local items = PlayerData.items
        local ItemsJson = {}
        if items and next(items) then
            for slot, item in pairs(items) do
                if items[slot] then
                    ItemsJson[#ItemsJson+1] = {
                        name = item.name,
                        amount = item.amount,
                        info = item.info,
                        type = item.type,
                        slot = slot,
                    }
                end
            end
            MySQL.Async.prepare('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode(ItemsJson), PlayerData.citizenid })
        else
            MySQL.Async.prepare('UPDATE players SET inventory = ? WHERE citizenid = ?', { '[]', PlayerData.citizenid })
        end
    end
end

-- Util Functions

function QBCore.Player.GetTotalWeight(items)
    local weight = 0
    if items then
        for slot, item in pairs(items) do
            weight = weight + (item.weight * item.amount)
        end
    end
    return tonumber(weight)
end

function QBCore.Player.GetSlotsByItem(items, itemName)
    local slotsFound = {}
    if items then
        for slot, item in pairs(items) do
            if item.name:lower() == itemName:lower() then
                slotsFound[#slotsFound+1] = slot
            end
        end
    end
    return slotsFound
end

function QBCore.Player.GetFirstSlotByItem(items, itemName)
    if items then
        for slot, item in pairs(items) do
            if item.name:lower() == itemName:lower() then
                return tonumber(slot)
            end
        end
    end
    return nil
end

function QBCore.Player.CreateCitizenId()
    local UniqueFound = false
    local CitizenId = nil
    while not UniqueFound do
        CitizenId = tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(5)):upper()
        local result = MySQL.Sync.prepare('SELECT COUNT(*) as count FROM players WHERE citizenid = ?', { CitizenId })
        if result == 0 then
            UniqueFound = true
        end
    end
    return CitizenId
end

function QBCore.Player.CreateFingerId()
    local UniqueFound = false
    local FingerId = nil
    while not UniqueFound do
        FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
        local query = '%' .. FingerId .. '%'
        local result = MySQL.Sync.prepare('SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE ?', { query })
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
        local result = MySQL.Sync.prepare('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })
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
        local result = MySQL.Sync.prepare('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return SerialNumber
end

PaycheckLoop() -- This just starts the paycheck system

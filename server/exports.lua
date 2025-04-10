--- Add or change (a) method(s) in the QBCore.Functions table
--- @param methodName string
--- @param handler function
--- @return boolean, string
local function SetMethod(methodName, handler)
    if type(methodName) ~= 'string' then
        return false, 'invalid_method_name'
    end

    QBCore.Functions[methodName] = handler

    TriggerEvent('QBCore:Server:UpdateObject')

    return true, 'success'
end

QBCore.Functions.SetMethod = SetMethod
exports('SetMethod', SetMethod)

--- Add or change (a) field(s) in the QBCore table
--- @param fieldName string
--- @param data any
--- @return boolean, string
local function SetField(fieldName, data)
    if type(fieldName) ~= 'string' then
        return false, 'invalid_field_name'
    end

    QBCore[fieldName] = data

    TriggerEvent('QBCore:Server:UpdateObject')

    return true, 'success'
end

QBCore.Functions.SetField = SetField
exports('SetField', SetField)

--- Single add job function which should only be used if you planning on adding a single job
--- @param jobName string
--- @param job table
--- @return boolean, string
local function AddJob(jobName, job)
    if type(jobName) ~= 'string' then
        return false, 'invalid_job_name'
    end

    if QBCore.Shared.Jobs[jobName] then
        return false, 'job_exists'
    end

    QBCore.Shared.Jobs[jobName] = job

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Jobs', jobName, job)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.AddJob = AddJob
exports('AddJob', AddJob)

--- Multiple Add Jobs
--- @param jobs table
--- @return boolean, string, table?
local function AddJobs(jobs)
    local shouldContinue = true
    local message = 'success'
    local errorItem = nil

    for key, value in pairs(jobs) do
        if type(key) ~= 'string' then
            message = 'invalid_job_name'
            shouldContinue = false
            errorItem = jobs[key]
            break
        end

        if QBCore.Shared.Jobs[key] then
            message = 'job_exists'
            shouldContinue = false
            errorItem = jobs[key]
            break
        end

        QBCore.Shared.Jobs[key] = value
    end

    if not shouldContinue then return false, message, errorItem end
    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Jobs', jobs)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, message, nil
end

QBCore.Functions.AddJobs = AddJobs
exports('AddJobs', AddJobs)

--- Single Remove Job
--- @param jobName string
--- @return boolean, string
local function RemoveJob(jobName)
    if type(jobName) ~= 'string' then
        return false, 'invalid_job_name'
    end

    if not QBCore.Shared.Jobs[jobName] then
        return false, 'job_not_exists'
    end

    QBCore.Shared.Jobs[jobName] = nil

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Jobs', jobName, nil)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.RemoveJob = RemoveJob
exports('RemoveJob', RemoveJob)

--- Single Update Job
--- @param jobName string
--- @param job table
--- @return boolean, string
local function UpdateJob(jobName, job)
    if type(jobName) ~= 'string' then
        return false, 'invalid_job_name'
    end

    if not QBCore.Shared.Jobs[jobName] then
        return false, 'job_not_exists'
    end

    QBCore.Shared.Jobs[jobName] = job

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Jobs', jobName, job)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.UpdateJob = UpdateJob
exports('UpdateJob', UpdateJob)

--- Single add item
--- @param itemName string
--- @param item table
--- @return boolean, string
local function AddItem(itemName, item)
    if type(itemName) ~= 'string' then
        return false, 'invalid_item_name'
    end

    if QBCore.Shared.Items[itemName] then
        return false, 'item_exists'
    end

    QBCore.Shared.Items[itemName] = item

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Items', itemName, item)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.AddItem = AddItem
exports('AddItem', AddItem)

--- Single update item
--- @param itemName string
--- @param item table
--- @return boolean, string
local function UpdateItem(itemName, item)
    if type(itemName) ~= 'string' then
        return false, 'invalid_item_name'
    end
    if not QBCore.Shared.Items[itemName] then
        return false, 'item_not_exists'
    end
    QBCore.Shared.Items[itemName] = item
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Items', itemName, item)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.UpdateItem = UpdateItem
exports('UpdateItem', UpdateItem)

--- Multiple Add Items
--- @param items table
--- @return boolean, string, table?
local function AddItems(items)
    local shouldContinue = true
    local message = 'success'
    local errorItem = nil

    for key, value in pairs(items) do
        if type(key) ~= 'string' then
            message = 'invalid_item_name'
            shouldContinue = false
            errorItem = items[key]
            break
        end

        if QBCore.Shared.Items[key] then
            message = 'item_exists'
            shouldContinue = false
            errorItem = items[key]
            break
        end

        QBCore.Shared.Items[key] = value
    end

    if not shouldContinue then return false, message, errorItem end
    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Items', items)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, message, nil
end

QBCore.Functions.AddItems = AddItems
exports('AddItems', AddItems)

--- Single Remove Item
--- @param itemName string
--- @return boolean, string
local function RemoveItem(itemName)
    if type(itemName) ~= 'string' then
        return false, 'invalid_item_name'
    end

    if not QBCore.Shared.Items[itemName] then
        return false, 'item_not_exists'
    end

    QBCore.Shared.Items[itemName] = nil

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Items', itemName, nil)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.RemoveItem = RemoveItem
exports('RemoveItem', RemoveItem)

--- Single Add Gang
--- @param gangName string
--- @param gang table
--- @return boolean, string
local function AddGang(gangName, gang)
    if type(gangName) ~= 'string' then
        return false, 'invalid_gang_name'
    end

    if QBCore.Shared.Gangs[gangName] then
        return false, 'gang_exists'
    end

    QBCore.Shared.Gangs[gangName] = gang

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Gangs', gangName, gang)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.AddGang = AddGang
exports('AddGang', AddGang)

--- Multiple Add Gangs
--- @param gangs table
--- @return boolean, string, table?
local function AddGangs(gangs)
    local shouldContinue = true
    local message = 'success'
    local errorItem = nil

    for key, value in pairs(gangs) do
        if type(key) ~= 'string' then
            message = 'invalid_gang_name'
            shouldContinue = false
            errorItem = gangs[key]
            break
        end

        if QBCore.Shared.Gangs[key] then
            message = 'gang_exists'
            shouldContinue = false
            errorItem = gangs[key]
            break
        end

        QBCore.Shared.Gangs[key] = value
    end

    if not shouldContinue then return false, message, errorItem end
    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Gangs', gangs)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, message, nil
end

QBCore.Functions.AddGangs = AddGangs
exports('AddGangs', AddGangs)

--- Single Remove Gang
--- @param gangName string
--- @return boolean, string
local function RemoveGang(gangName)
    if type(gangName) ~= 'string' then
        return false, 'invalid_gang_name'
    end

    if not QBCore.Shared.Gangs[gangName] then
        return false, 'gang_not_exists'
    end

    QBCore.Shared.Gangs[gangName] = nil

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Gangs', gangName, nil)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.RemoveGang = RemoveGang
exports('RemoveGang', RemoveGang)

--- Single Update Gang
--- @param gangName string
--- @param gang table
--- @return boolean, string
local function UpdateGang(gangName, gang)
    if type(gangName) ~= 'string' then
        return false, 'invalid_gang_name'
    end

    if not QBCore.Shared.Gangs[gangName] then
        return false, 'gang_not_exists'
    end

    QBCore.Shared.Gangs[gangName] = gang

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Gangs', gangName, gang)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, 'success'
end

QBCore.Functions.UpdateGang = UpdateGang
exports('UpdateGang', UpdateGang)

local resourceName = GetCurrentResourceName()

--- Get the version of the core
--- @param InvokingResource string
--- @return string
local function GetCoreVersion(InvokingResource)
    local resourceVersion = GetResourceMetadata(resourceName, 'version', 0)
    if InvokingResource and InvokingResource ~= '' then
        print(('%s called qbcore version check: %s'):format(InvokingResource or 'Unknown Resource', resourceVersion))
    end
    return resourceVersion
end

QBCore.Functions.GetCoreVersion = GetCoreVersion
exports('GetCoreVersion', GetCoreVersion)

--- Ban a player for exploiting
--- @param playerId number | string
--- @param origin string
local function ExploitBan(playerId, origin)
    local name = GetPlayerName(playerId)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        name,
        QBCore.Functions.GetIdentifier(playerId, 'license'),
        QBCore.Functions.GetIdentifier(playerId, 'discord'),
        QBCore.Functions.GetIdentifier(playerId, 'ip'),
        origin,
        2147483647,
        'Anti Cheat'
    })
    DropPlayer(tostring(playerId), Lang:t('info.exploit_banned', { discord = QBCore.Config.Server.Discord }))
    TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'red', name .. ' has been banned for exploiting ' .. origin, true)
end

exports('ExploitBan', ExploitBan)

-- Single add job function which should only be used if you planning on adding a single job
local function AddJob(jobName, job)
    if type(jobName) ~= "string" then
        return false, "invalid_job_name"
    end

    if QBCore.Shared.Jobs[jobName] then
        return false, "job_exists"
    end

    QBCore.Shared.Jobs[jobName] = job
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1,'Jobs', jobName, job)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, "success"
end
QBCore.Functions.AddJob = AddJob
exports('AddJob', AddJob)

-- Multiple Add Jobs
local function AddJobs(jobs)
    local shouldContinue = true
    local message = "success"
    local errorItem = nil
    for key, value in pairs(jobs) do
        if type(key) ~= "string" then
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

-- Single add item
local function AddItem(itemName, item)
    if type(itemName) ~= "string" then
        return false, "invalid_item_name"
    end

    if QBCore.Shared.Items[itemName] then
        return false, "item_exists"
    end

    QBCore.Shared.Items[itemName] = item
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Items', itemName, item)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, "success"
end
QBCore.Functions.AddItem = AddItem
exports('AddItem', AddItem)

-- Multiple Add Items
local function AddItems(items)
    local shouldContinue = true
    local message = "success"
    local errorItem = nil
    for key, value in pairs(items) do
        if type(key) ~= "string" then
            message = "invalid_item_name"
            shouldContinue = false
            errorItem = items[key]
            break
        end

        if QBCore.Shared.Items[key] then
            message = "item_exists"
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

-- Single Add Gang
local function AddGang(gangName, gang)
    if type(gangName) ~= "string" then
        return false, "invalid_gang_name"
    end
    if QBCore.Shared.Gangs[gangName] then
        return false, "gang_exists"
    end

    QBCore.Shared.Gangs[gangName] = gang
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Gangs', gangName, gang)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, "success"
end
QBCore.Functions.AddGang = AddGang
exports('AddGang', AddGang)

-- Multiple Add Gangs
local function AddGangs(gangs)
    local shouldContinue = true
    local message = "success"
    local errorItem = nil
    for key, value in pairs(gangs) do
        if type(key) ~= "string" then
            message = "invalid_gang_name"
            shouldContinue = false
            errorItem = gangs[key]
            break
        end

        if QBCore.Shared.Gangs[key] then
            message = "gang_exists"
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

local function GetCoreVersion(InvokingResource)
    local resourceVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
    if InvokingResource and InvokingResource ~= '' then
        print(("%s called qbcore version check: %s"):format(InvokingResource or 'Unknown Resource', resourceVersion))
    end
    return resourceVersion
end
QBCore.Functions.GetCoreVersion = GetCoreVersion
exports('GetCoreVersion', GetCoreVersion)

-- Single add job function which should only be used if you planning on adding a single job
local function AddJob(jobName, job, source)
    if type(jobName) ~= "string" then
        print('Failed to add the item, name is not a string')
        if source ~= nil and source ~= '' then
            TriggerClientEvent('QBCore:Notify', source, 'Failed to add the job, name is not a string', 'error', 3000)
        end
        return false
    end

    if QBCore.Shared.Jobs[jobName] ~= nil then
        print('Failed to add the item, item already exists')
        if source ~= nil and source ~= '' then
            TriggerClientEvent('QBCore:Notify', source, 'Failed to add the job, job already exists', 'error', 3000)
        end
        return false
    end

    QBCore.Shared.Jobs[jobName] = job
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1,'Jobs', jobName, job)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true
end
QBCore.Functions.AddJob = AddJob
exports('AddJob', AddJob)

-- Multiple Add Jobs
local function AddJobs(jobs)
    local shouldContinue = true
    for key, value in pairs(jobs) do
        if type(key) ~= "string" then
            print('Failed to add the job, name is not a string')
            shouldContinue = false
            goto continue
        end

        if QBCore.Shared.Jobs[key] ~= nil then
            print('Failed to add the job, job already exists: ' .. key)
            shouldContinue = false
            goto continue
        end

        QBCore.Shared.Jobs[key] = value
        ::continue::
    end

    if not shouldContinue then return false end
    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Jobs', jobs)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true
end
QBCore.Functions.AddJobs = AddJobs
exports('AddJobs', AddJobs)

-- Single add item
local function AddItem(itemName, item, source)
    if type(itemName) ~= "string" then
        print('Failed to add the item, name is not a string')
        if source ~= nil and source ~= '' then
            TriggerClientEvent('QBCore:Notify', source, 'Failed to add the item, name is not a string', 'error', 3000)
        end
        return false
    end
    if QBCore.Shared.Items[itemName] ~= nil then
        print('Failed to add the item, item already exists')
        if source ~= nil and source ~= '' then
            TriggerClientEvent('QBCore:Notify', source, 'Failed to add the item, item already exists', 'error', 3000)
        end
        return false
    end

    QBCore.Shared.Items[itemName] = item
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Items', itemName, item)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true
end
QBCore.Functions.AddItem = AddItem
exports('AddItem', AddItem)

-- Multiple Add Items
local function AddItems(items)
    local shouldContinue = true
    for key, value in pairs(items) do
        if type(key) ~= "string" then
            print('Failed to add the item, name is not a string')
            shouldContinue = false
            goto continue
        end

        if QBCore.Shared.Items[key] ~= nil then
            print('Failed to add the item, item already exists: ' .. key)
            shouldContinue = false
            goto continue
        end

        QBCore.Shared.Items[key] = value
        ::continue::
    end
    if not shouldContinue then return false end
    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Items', items)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true
end
QBCore.Functions.AddItems = AddItems
exports('AddItems', AddItems)

-- Single Add Gang
local function AddGang(gangName, gang, source)
    if type(gangName) ~= "string" then
        print('Failed to add the gang, name is not a string')
        if source ~= nil and source ~= '' then
            TriggerClientEvent('QBCore:Notify', source, 'Failed to add the gang, name is not a string', 'error', 3000)
        end
        return false
    end
    if QBCore.Shared.Gangs[gangName] ~= nil then
        print('Failed to add the gang, gang already exists')
        if source ~= nil and source ~= '' then
            TriggerClientEvent('QBCore:Notify', source, 'Failed to add the gang, gang already exists', 'error', 3000)
        end
        return false
    end

    QBCore.Shared.Gangs[gangName] = gang
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1,'Gangs', gangName, gang)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true
end
QBCore.Functions.AddGang = AddGang
exports('AddGang', AddGang)

-- Multiple Add Gangs
local function AddGangs(gangs)
    local shouldContinue = true

    for key, value in pairs(gangs) do
        if type(key) ~= "string" then
            print('Failed to add the gang, name is not a string')
            shouldContinue = false
            goto continue
        end

        if QBCore.Shared.Gangs[key] ~= nil then
            print('Failed to add the gang, gang already exists: ' .. key)
            shouldContinue = false
            goto continue
        end

        QBCore.Shared.Gangs[key] = value
        ::continue::
    end

    if not shouldContinue then return false end
    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Gangs', gangs)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true
end
QBCore.Functions.AddGangs = AddGangs
exports('AddGangs', AddGangs)
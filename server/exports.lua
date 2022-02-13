-- Single add job function which should only be used if you planning on adding a single job
local function AddJob(jobName, job)
    QBCore.Shared.Jobs[jobName] = job
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1,'Jobs', jobName, job)
    TriggerEvent('QBCore:Server:UpdateObject')
end
QBCore.Functions.AddJob = AddJob
exports('AddJob', AddJob)

-- Multiple Add Jobs
local function AddJobs(jobs)
    for key, value in pairs(jobs) do
        QBCore.Shared.Jobs[key] = value
    end

    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Jobs', jobs)
    TriggerEvent('QBCore:Server:UpdateObject')
end
QBCore.Functions.AddJobs = AddJobs
exports('AddJobs', AddJobs)

-- Single add item
local function AddItem(itemName, item)
    QBCore.Shared.Items[itemName] = item
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Items', itemName, item)
    TriggerEvent('QBCore:Server:UpdateObject')
end
QBCore.Functions.AddItem = AddItem
exports('AddItem', AddItem)

-- Multiple Add Items
local function AddItems(items)
    for key, value in pairs(items) do
        QBCore.Shared.Items[key] = value
    end

    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Items', items)
    TriggerEvent('QBCore:Server:UpdateObject')
end
QBCore.Functions.AddItems = AddItems
exports('AddItems', AddItems)

-- Single Add Gang
local function AddGang(gangName, gang)
    QBCore.Shared.Gangs[gangName] = gang
    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1,'Gangs', gangName, gang)
    TriggerEvent('QBCore:Server:UpdateObject')
end
QBCore.Functions.AddGang = AddGang
exports('AddGang', AddGang)

-- Multiple Add Gangs
local function AddGangs(gangs)
    for key, value in pairs(gangs) do
        QBCore.Shared.Gangs[key] = value
    end

    TriggerClientEvent('QBCore:Client:OnSharedUpdateMultiple', -1, 'Gangs', gangs)
    TriggerEvent('QBCore:Server:UpdateObject')
end
QBCore.Functions.AddGangs = AddGangs
exports('AddGangs', AddGangs)
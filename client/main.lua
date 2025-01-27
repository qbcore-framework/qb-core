QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}

-- Get the full QBCore object (default behavior):
-- local QBCore = GetCoreObject()

-- Get only specific parts of QBCore:
-- local QBCore = GetCoreObject({'Players', 'Config'})

local function GetCoreObject(filters)
    if not filters then return QBCore end
    local results = {}
    for i = 1, #filters do
        local key = filters[i]
        if QBCore[key] then
            results[key] = QBCore[key]
        end
    end
    return results
end
exports('GetCoreObject', GetCoreObject)

local function GetSharedItems()
    return QBShared.Items
end
exports('GetSharedItems', GetSharedItems)

local function GetSharedVehicles()
    return QBShared.Vehicles
end
exports('GetSharedVehicles', GetSharedVehicles)

local function GetSharedWeapons()
    return QBShared.Weapons
end
exports('GetSharedWeapons', GetSharedWeapons)

local function GetSharedJobs()
    return QBShared.Jobs
end
exports('GetSharedJobs', GetSharedJobs)

local function GetSharedGangs()
    return QBShared.Gangs
end
exports('GetSharedGangs', GetSharedGangs)

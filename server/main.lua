QBCore = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}

-- Get the full QBCore object (default behavior):
-- local QBCore = GetCoreObject()

-- Get only specific parts of QBCore:
-- local QBCore = GetCoreObject({'Players', 'Config'})

--- Gets the QBCore object
--- @param filters table
--- @return table
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

--- Gets the QBCore Items
--- @return table
local function GetSharedItems()
    return QBShared.Items
end
exports('GetSharedItems', GetSharedItems)

--- Gets the QBCore Vehicles
--- @return table
local function GetSharedVehicles()
    return QBShared.Vehicles
end
exports('GetSharedVehicles', GetSharedVehicles)

--- Gets the QBCore Weapons
--- @return table
local function GetSharedWeapons()
    return QBShared.Weapons
end
exports('GetSharedWeapons', GetSharedWeapons)

--- Gets the QBCore Jobs
--- @return table
local function GetSharedJobs()
    return QBShared.Jobs
end
exports('GetSharedJobs', GetSharedJobs)

--- Gets the QBCore Gangs
--- @return table
local function GetSharedGangs()
    return QBShared.Gangs
end
exports('GetSharedGangs', GetSharedGangs)

QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}

--- Get the full QBCore object (default behavior) or a specific part of the core
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

--- Get the QBCore items
--- @return table
local function GetSharedItems()
    return QBShared.Items
end
exports('GetSharedItems', GetSharedItems)

--- Get the QBCore vehicles
--- @return table
local function GetSharedVehicles()
    return QBShared.Vehicles
end
exports('GetSharedVehicles', GetSharedVehicles)

--- Get the QBCore weapons
--- @return table
local function GetSharedWeapons()
    return QBShared.Weapons
end
exports('GetSharedWeapons', GetSharedWeapons)

--- Get the QBCore jobs
--- @return table
local function GetSharedJobs()
    return QBShared.Jobs
end
exports('GetSharedJobs', GetSharedJobs)

--- Get the QBCore gangs
--- @return table
local function GetSharedGangs()
    return QBShared.Gangs
end
exports('GetSharedGangs', GetSharedGangs)

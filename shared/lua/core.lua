QBCore = {
    Config = {},
    Shared = {
        Jobs = {},
        Gangs = {},
        Items = {},
        Vehicles = {},
        Weapons = {},
        VehicleHashes = {},
    },
    Player = {},
    Players = {},
    PlayerData = {},
    Functions = {},
    ClientCallbacks = {},
    ServerCallbacks = {},
    Player_Buckets = {},
    Entity_Buckets = {},
    UsableItems = {},
    Commands = {
        List = {},
        IgnoreList = {
            ['god'] = true,
            ['user'] = true
        }
    }
}

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
exports('GetSharedItems', function() return QBCore.Shared.Items end)
exports('GetSharedVehicles', function() return QBCore.Shared.Vehicles end)
exports('GetSharedWeapons', function() return QBCore.Shared.Weapons end)
exports('GetSharedJobs', function() return QBCore.Shared.Jobs end)
exports('GetSharedGangs', function() return QBCore.Shared.Gangs end)

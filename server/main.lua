QBCore = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}

--[[ --filters example
    local QBCore = exports['qb-core']:GetCoreObject({
        Functions = {
            GetPlayer = true,
            Notify = true,
        },
        Shared = {
            Vehicles = true,
        },
    })
]]
    
---@param filters table
---@return table
exports('GetCoreObject', function(filters)
    if filters then return QBCore.Functions.GetFiltered(QBCore, filters) end
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['qb-core']:GetCoreObject()

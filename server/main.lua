QBCore = {}
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

CreateThread(function()
    local col = 'userId'
    local tbl = 'players'
    local exists = MySQL.prepare.await('SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = ? AND COLUMN_NAME = ?', { tbl, col })
    if QBConfig.Server.StaticId.Enabled then
        if exists == 0 then
            MySQL.query.await('ALTER TABLE `players` ADD COLUMN `userId` INT NULL DEFAULT NULL, ADD INDEX `userId_idx` (`userId`)')
        end
        local rows = MySQL.query.await('SELECT citizenid, userId FROM players')
        if rows then
            for i = 1, #rows do
                local r = rows[i]
                if not r.userId or r.userId == 0 then
                    local newId = QBCore.Player.CreatePlayerId()
                    MySQL.update.await('UPDATE players SET userId = ? WHERE citizenid = ?', { newId, r.citizenid })
                end
            end
        end
    else
        if exists > 0 then
            MySQL.query.await('ALTER TABLE `players` DROP COLUMN `userId`')
        end
    end
end)

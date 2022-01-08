QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ServerCallbacks = {}

exports('GetCoreObject', function()
    return QBCore
end)

RegisterCommand('test', function()
    local Player = QBCore.Functions.GetPlayerData()
    print('^6[^4QB-Core^6]', ('%s %s has executed Hello World!'):format(Player.charinfo.firstname, Player.charinfo.lastname))
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['qb-core']:GetCoreObject()
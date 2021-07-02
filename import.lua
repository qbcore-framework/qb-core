function GetSharedObject()
    return QBCore
end

exports('GetSharedObject', GetSharedObject)

QBCore = exports['qb-core']:GetSharedObject()
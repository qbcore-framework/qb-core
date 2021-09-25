-- This might eventually be deprecated for the export system

if GetCurrentResourceName() == 'qb-core' then
    function GetSharedObject()
        return QBCore
    end

    exports('GetSharedObject', GetSharedObject)
end

QBCore = exports['qb-core']:GetSharedObject()
if GetCurrentResourceName() == 'qb-core' then 
    function GetSharedObject()
        return QBCore
    end

    exports('GetSharedObject', GetSharedObject)
end

QBCore = exports['qb-core']:GetSharedObject()

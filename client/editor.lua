RegisterNUICallback('saveConfig', function(data, cb)
    local file = data.file
    local configData = data.data
    TriggerServerEvent('qb-core:server:configEditor', file, configData)
    print('Saving config for file:', file)
    cb('ok')
end)

RegisterNUICallback('closeEditor', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('qb-core:client:configEditor', function(allData)
    SendNUIMessage({
        action = 'populateData',
        data = allData
    })
    SetNuiFocus(true, true)
end)

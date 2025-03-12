RegisterCommand('qbeditor', function(source)
    local files = {
        config = LoadResourceFile('qb-core', 'shared/json/config.json'),
        gangs = LoadResourceFile('qb-core', 'shared/json/gangs.json'),
        items = LoadResourceFile('qb-core', 'shared/json/items.json'),
        jobs = LoadResourceFile('qb-core', 'shared/json/jobs.json'),
        playerdata = LoadResourceFile('qb-core', 'shared/json/player_defaults.json'),
        vehicles = LoadResourceFile('qb-core', 'shared/json/vehicles.json'),
        weapons = LoadResourceFile('qb-core', 'shared/json/weapons.json'),
    }

    local allData = {}
    for key, fileContent in pairs(files) do
        if not fileContent then
            print('^1[QBCore] Failed to load ' .. key .. ' JSON File')
        else
            allData[key] = json.decode(fileContent)
        end
    end

    TriggerClientEvent('qb-core:client:configEditor', source, allData)
end, true)

RegisterNetEvent('qb-core:server:configEditor', function(fileName, fileData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not QBCore.Functions.HasPermission('god') then
        local filePaths = {
            ['config'] = 'shared/json/config.json',
            ['gangs'] = 'shared/json/gangs.json',
            ['items'] = 'shared/json/items.json',
            ['jobs'] = 'shared/json/jobs.json',
            ['playerdata'] = 'shared/json/player_defaults.json',
            ['vehicles'] = 'shared/json/vehicles.json',
            ['weapons'] = 'shared/json/weapons.json'
        }
        local filePath = filePaths[fileName]
        if not filePath then
            print('^1[QBCore] Invalid file name: ' .. fileName)
            return
        end
        local encodedData = json.encode(fileData, { indent = true })
        local saved = SaveResourceFile('qb-core', filePath, encodedData, -1)
        if saved then
            print('^2[QBCore] Player ' .. GetPlayerName(src) .. ' (ID: ' .. src .. ') successfully saved ' .. fileName .. ' configuration')
            TriggerClientEvent('QBCore:Notify', src, 'Configuration saved successfully', 'success')
        else
            print('^1[QBCore] Failed to save ' .. fileName .. ' configuration')
            TriggerClientEvent('QBCore:Notify', src, 'Failed to save configuration', 'error')
        end
    else
        print('^1[QBCore] Player ' .. GetPlayerName(src) .. ' (ID: ' .. src .. ') attempted to save ' .. fileName .. ' configuration without permission')
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have permission to edit configs', 'error')
    end
end)

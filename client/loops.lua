CreateThread(function()
    while true do
        Wait(0)
        if LocalPlayer.state.isLoggedIn then
            Wait((1000 * 60) * QBCore.Config.UpdateInterval)
            TriggerServerEvent('QBCore:UpdatePlayer')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(QBCore.Config.StatusInterval)
        local PlayerData = QBCore.Functions.GetPlayerData() 
        if LocalPlayer.state.isLoggedIn then
            if (PlayerData.metadata['hunger'] <= 0 or PlayerData.metadata['thirst'] <= 0) and (not PlayerData.metadata['isdead']) then		
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                SetEntityHealth(ped, currentHealth - math.random(5, 10))
            end
        end
    end
end)

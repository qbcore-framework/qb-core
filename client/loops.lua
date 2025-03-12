-- CreateThread(function()
--     while not NetworkIsSessionStarted() do Wait(500) end
--     print('player has loaded at this point')
-- end)

CreateThread(function()
    while true do
        local sleep = 1000
        if LocalPlayer.state.isLoggedIn then
            sleep = (1000 * 60) * QBCore.Config.UpdateInterval
            TriggerServerEvent('QBCore:UpdatePlayer')
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            if (LocalPlayer.state['metadata:hunger'] <= 0 or LocalPlayer.state['metadata:thirst'] <= 0)
                and not (LocalPlayer.state['metadata:isdead'] or LocalPlayer.state['metadata:inlaststand']) then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                local decreaseThreshold = math.random(5, 10)
                if currentHealth - decreaseThreshold > 0 then
                    SetEntityHealth(ped, currentHealth - decreaseThreshold)
                else
                    SetEntityHealth(ped, 0)
                end
            end
        end
        Wait(QBCore.Config.StatusInterval)
    end
end)

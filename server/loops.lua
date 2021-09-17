PaycheckLoop = function()
    local Players = QBCore.Functions.GetPlayers()

    for i=1, #Players, 1 do
        local Player = QBCore.Functions.GetPlayer(Players[i])

        if Player.PlayerData.job ~= nil and Player.PlayerData.job.payment > 0 then
            if Player.PlayerData.job.onduty then 
                Player.Functions.AddMoney('bank', Player.PlayerData.job.payment)
                TriggerClientEvent('QBCore:Notify', Players[i], "You received your paycheck of $"..Player.PlayerData.job.payment)
            else
                TriggerClientEvent('QBCore:Notify', Players[i], "You are not on duty and will not receive payment from your job!")
            end
        end
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckLoop)
end

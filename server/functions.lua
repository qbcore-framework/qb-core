function PaycheckInterval()
    if not next(QBCore.Players) then 
        SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckInterval) -- Prevent paychecks from stopping forever once 0 players
        return 
    end
    for _, Player in pairs(QBCore.Players) do
        if not Player then return end
        local payment = QBShared.Jobs[Player.PlayerData.job.name]['grades'][tostring(Player.PlayerData.job.grade.level)].payment
        if not payment then payment = Player.PlayerData.job.payment end
        if Player.PlayerData.job and payment > 0 and (QBShared.Jobs[Player.PlayerData.job.name].offDutyPay or Player.PlayerData.job.onduty) then
            if QBCore.Config.Money.PayCheckSociety then
                local account = exports['qb-banking']:GetAccountBalance(Player.PlayerData.job.name)
                if account ~= 0 then
                    if account < payment then
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('error.company_too_poor'), 'error')
                    else
                        Player.Functions.AddMoney('bank', payment, 'paycheck')
                        exports['qb-banking']:RemoveMoney(Player.PlayerData.job.name, payment, 'Employee Paycheck')
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
                    end
                else
                    Player.Functions.AddMoney('bank', payment, 'paycheck')
                    TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
                end
            else
                Player.Functions.AddMoney('bank', payment, 'paycheck')
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
            end
        end
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckInterval)
end

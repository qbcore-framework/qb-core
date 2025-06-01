local function givePlayerBank(player, amount)
    player.Functions.AddMoney('bank', amount, 'paycheck')
end

local function notify(player, langKey, amount)
    TriggerClientEvent(
        'QBCore:Notify',
        player.PlayerData.source,
        Lang:t(langKey, { value = amount }),
        'success'
    )
end

local function payFromSociety(player, amount)
    local acctName = player.PlayerData.job.name
    local balance  = exports['qb-banking']:GetAccountBalance(acctName)
    if balance >= amount then
        exports['qb-banking']:RemoveMoney(acctName, amount, 'Employee Paycheck')
        givePlayerBank(player, amount)
        notify(player, 'info.received_paycheck', amount)
    elseif balance > 0 then
        TriggerClientEvent('QBCore:Notify', player.PlayerData.source, Lang:t('error.company_too_poor'), 'error')
    else
        givePlayerBank(player, amount)
        notify(player, 'info.received_paycheck', amount)
    end
end

local function handlePaycheck(player, amount)
    if QBCore.Config.Money.PayCheckSociety then
        payFromSociety(player, amount)
    else
        givePlayerBank(player, amount)
        notify(player, 'info.received_paycheck', amount)
    end
end

local function shouldReceivePay(player)
    local jobDef = QBCore.Shared.Jobs[player.PlayerData.job.name]
    local onDuty = player.PlayerData.job.onduty
    return jobDef.offDutyPay or onDuty
end

local function getPlayerPayment(player)
    local jobDef   = QBCore.Shared.Jobs[player.PlayerData.job.name]
    local gradeDef = jobDef.grades[tostring(player.PlayerData.job.grade.level)]
    return gradeDef.payment or player.PlayerData.job.payment or 0
end

local function isPlayerValid(player)
    if not player or not player.PlayerData or not player.PlayerData.job then
        print(('Paycheck: invalid player data (source=%s)'):format(
            tostring(player and player.PlayerData and player.PlayerData.source or 'nil')
        ))
        return false
    end

    local jobName = player.PlayerData.job.name
    local jobDef  = QBCore.Shared.Jobs[jobName]
    if not jobDef then
        print(("Paycheck: tried paying for job '%s' that doesn't exist"):format(jobName))
        return false
    end

    local gradeLevel = tostring(player.PlayerData.job.grade.level)
    local gradeDef   = jobDef.grades[gradeLevel]
    if not gradeDef then
        print(("Paycheck: tried paying for job '%s' with invalid grade '%s'"):format(jobName, gradeLevel))
        return false
    end

    return true
end

local function ProcessAllPaychecks()
    for _, player in pairs(QBCore.Players) do
        if isPlayerValid(player) then
            local payment = getPlayerPayment(player)
            if payment > 0 and shouldReceivePay(player) then
                handlePaycheck(player, payment)
            end
        end
    end
end

Citizen.CreateThread(function()
    local interval = QBCore.Config.Money.PayCheckTimeOut * 60 * 1000
    while true do
        Wait(interval)
        ProcessAllPaychecks()
    end
end)

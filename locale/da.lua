local Translations = {
    error = {
        not_online = 'Spiller er ikke i byen',
        wrong_format = 'Forkert format',
        missing_args = 'Du mangler nogle argumenter (x, y, z)',
        missing_args2 = 'Alle argumenter skal skrives ind!',
        no_access = 'Du har ikke adgang til denne kommando',
        company_too_poor = 'Din chef er fattig',
        item_not_exist = 'Ting findes ikke',
        too_heavy = 'Tasken er fyldt',
        duplicate_license = 'Duplicate Rockstar License Found',
        no_valid_license  = 'Intet gyldig Rockstar-licens fundet',
        not_whitelisted = 'Du er ikke allowlistet på denne server'
    },
    success = {},
    info = {
        received_paycheck = 'You received your paycheck of DKK%{value}',
        job_info = 'Job: %{value} | Grad: %{value2} | Duty: %{value3}',
        gang_info = 'Bande: %{value} | Grad: %{value2}',
        on_duty = 'Du er nu på vagt!',
        off_duty = 'Du har nu fri!',
        checking_ban = 'Hej %s. Vi kontrollerer, om du er bannet.',
        join_server = 'Velkommen %s til {Server Name}.',
        checking_whitelisted = 'Hej %s. Vi tjekker om du er allowlistet.'
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

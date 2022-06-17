local Translations = {
    error = {
        not_online = 'Spelaren är inte online',
        wrong_format = 'Felaktigt format',
        missing_args = 'Alla argument har inte angetts (x, y, z)',
        missing_args2 = 'Alla argument måste fyllas i!',
        no_access = 'Du har inte tillgång till detta kommando',
        company_too_poor = 'Din arbetsgivare är pank',
        item_not_exist = 'Objektet finns inte',
        too_heavy = 'Ditt inventory är fullt!',
        duplicate_license = 'Duplicerad Rockstar Licens Funnet',
        no_valid_license  = 'Ingen Giltig Rockstar Licens Hittades',
        not_whitelisted = 'Du är inte whitelistad på servern'
    },
    success = {},
    info = {
        received_paycheck = 'Du fick din lönecheck på SEK%{value}',
        job_info = 'Jobb: %{value} | Grad: %{value2} | Tjänst: %{value3}',
        gang_info = 'Gäng: %{value} | Grad: %{value2}',
        on_duty = 'Du är nu i tjänst!',
        off_duty = 'Du har gått ur tjänst!',
        checking_ban = 'Hej %s. Vi kollar ifall du är bannad.',
        join_server = 'Välkommen %s till Bygden RP.',
        checking_whitelisted = 'Hej %s. Vi kollar efter giltighet i ditt medlemskap.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

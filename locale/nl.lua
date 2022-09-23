local Translations = {
    error = {
        not_online = 'Speler is niet online',
        wrong_format = 'Onjuiste opmaak',
        missing_args = 'Niet elk argument is ingevuld (x, y, z)',
        missing_args2 = 'Alle argumenten moeten worden ingevuld!',
        no_access = 'Geen toegang tot dit commando',
        company_too_poor = 'Je werkgever is arm',
        item_not_exist = 'Item bestaat niet',
        too_heavy = 'Inventaris is te vol',
        duplicate_license = 'Dubbele Rockstar-licentie gevonden',
        no_valid_license  = 'Geen geldige Rockstar-licentie gevonden',
        not_whitelisted = 'Je staat niet op de whitelist voor deze server'
    },
    success = {},
    info = {
        received_paycheck = 'Je hebt je salaris van $%{value} ontvangen',
        job_info = 'Baan: %{value} | Rang: %{value2} | In dienst: %{value3}',
        gang_info = 'Gang: %{value} | Rang: %{value2}',
        on_duty = 'Je bent nu in dienst!',
        off_duty = 'Je bent nu uit dienst!',
        checking_ban = 'Hallo %s. We controleren of je verbannen bent.',
        join_server = 'Welkom %s bij {Server Name}.',
        checking_whitelisted = 'Hallo %s. We controleren of je op de whitelist staat.'
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

local Translations = {
    error = {
        not_online = 'Gracz nie jest online',
        wrong_format = 'Nieprawidłowy format',
        missing_args = 'Nie każdy argument został wprowadzony (x, y, z)',
        missing_args2 = 'Wszystkie argumenty muszą być wypełnione!',
        no_access = 'Brak dostępu do tego polecenia',
        company_too_poor = 'Twój pracodawca jest spłukany',
        item_not_exist = 'Przedmiot nie istnieje',
        too_heavy = 'Ekwipunek jest zbyt pełny',
        duplicate_license = 'Znaleziono zduplikowaną licencję Rockstar',
        no_valid_license  = 'Nie znaleziono ważnej licencji Rockstar',
        not_whitelisted = 'Nie jesteś na białej liście tego serwera'
    },
    success = {},
    info = {
        received_paycheck = 'Otrzymałeś czek w wysokości $%{value}',
        job_info = 'Praca: %{value} | Stopień: %{value2} | Służba: %{value3}',
        gang_info = 'Gang: %{value} | Stopień: %{value2}',
        on_duty = 'Jesteś teraz na służbie!',
        off_duty = 'Jesteś teraz po służbie!',
        checking_ban = 'Witaj %s. Sprawdzamy, czy jesteś zbanowany.',
        join_server = 'Witaj %s na {Server Name}.',
        checking_whitelisted = 'Witaj %s. Sprawdzamy Twoje kieszonkowe.'
    }
}

if GetConvar('qb_locale', 'en') == 'pl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

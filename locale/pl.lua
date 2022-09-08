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
        not_whitelisted = 'Nie jesteś na białej liście tego serwera',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Otrzymałeś czek w wysokości $%{value}',
        job_info = 'Praca: %{value} | Stopień: %{value2} | Służba: %{value3}',
        gang_info = 'Gang: %{value} | Stopień: %{value2}',
        on_duty = 'Jesteś teraz na służbie!',
        off_duty = 'Jesteś teraz po służbie!',
        join_server = 'Witaj %s na.',
        checking_ban = 'Checking banned status... 🔨',
        checking_whitelisted = 'Checking whitelist status... 👑',
        checking_license_credentials = 'Checking license credentials... 📖',
        checking_license_duplicate = 'Checking for duplicate license... ⛓️',
        password_header_normal = 'Input server password to join',
        password_header_maintenance = 'Server is currently under maitenance. Input Password to join.',
        password_prompt = 'Enter Password',
        password_submit = 'Submit',
        enter_maintenance_mode = "Entering Server Maintenance Mode",
    }
}

if GetConvar('qb_locale', 'en') == 'pl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

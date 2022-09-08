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
        not_whitelisted = 'Du är inte whitelistad på servern',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Du fick din lönecheck på SEK%{value}',
        job_info = 'Jobb: %{value} | Grad: %{value2} | Tjänst: %{value3}',
        gang_info = 'Gäng: %{value} | Grad: %{value2}',
        on_duty = 'Du är nu i tjänst!',
        off_duty = 'Du har gått ur tjänst!',
        join_server = 'Välkommen %s till Bygden RP.',
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

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

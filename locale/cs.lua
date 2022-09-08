local Translations = {
    error = {
        not_online = 'Hráč není online',
        wrong_format = 'Nesprávný formát',
        missing_args = 'Né všechny argumenty byly vyplněny (x, y, z)',
        missing_args2 = 'Všechny argumenty musí být vyplněný!',
        no_access = 'Nemáte přístup k tomuto příkazu',
        company_too_poor = 'Váš zaměstnavatel nemá dostatek peněz, aby vás vyplatil',
        item_not_exist = 'Předmět neexistuje',
        too_heavy = 'Inventář je plný',
        duplicate_license = 'Stejná Rockstar licence je již na serveru',
        no_valid_license  = 'Nebyla nalezena žádná platná Rockstar licence',
        not_whitelisted = 'Nejste na whitelistu',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Obdrželi jste výplatu v hodnotě $%{value}',
        job_info = 'Práce: %{value} | Pozice: %{value2} | Ve službě: %{value3}',
        gang_info = 'Gang: %{value} | Pozice: %{value2}',
        on_duty = 'Vešli jste do služby',
        off_duty = 'Odešli jste ze služby!',
        join_server = 'Vítejte %s na.',
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

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

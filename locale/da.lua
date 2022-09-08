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
        not_whitelisted = 'Du er ikke allowlistet på denne server',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'You received your paycheck of DKK%{value}',
        job_info = 'Job: %{value} | Grad: %{value2} | Duty: %{value3}',
        gang_info = 'Bande: %{value} | Grad: %{value2}',
        on_duty = 'Du er nu på vagt!',
        off_duty = 'Du har nu fri!',
        join_server = 'Velkommen %s til.',
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
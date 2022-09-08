local Translations = {
    error = {
        not_online = 'Spēlētājs nav online',
        wrong_format = 'Nepareizs formāts',
        missing_args = 'Ne visi argumenti tika ievadīti (x, y, z)',
        missing_args2 = 'Visiem argumentiem ir jābut aizpildītiem!',
        no_access = 'Nav piekļuve šai commandai',
        company_too_poor = 'Jūsu darba vedējs ir nabadzīgs',
        item_not_exist = 'Šī lieta nēeksistē',
        too_heavy = 'Inventārs ir pārāk pilns',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Jūs esat saņēmuši savu algu par $%{value}',
        job_info = 'Darbs: %{value} | Pakāpe: %{value2} | Pienākums: %{value3}',
        gang_info = 'Banda: %{value} | Pakāpe: %{value2}',
        on_duty = 'Jūs tagad esat dienestā!',
        off_duty = 'Jūs tagad esat atbrīvots no dienesta!',
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

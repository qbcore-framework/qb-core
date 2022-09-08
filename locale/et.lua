local Translations = {
    error = {
        not_online = 'Mängija pole serveris',
        wrong_format = 'Vale vorming',
        missing_args = 'Kõiki argumente pole sisestatud (x, y, z)',
        missing_args2 = 'Kõik argumendid tuleb täita!',
        no_access = 'Sellele käsule pole juurdepääsu',
        company_too_poor = 'Teie tööandja on võlgades',
        item_not_exist = 'Asi ei eksisteeri',
        too_heavy = 'Inventuur on liiga täis',
        duplicate_license = 'Leiti Rockstari litsentsi duplikaat',
        no_valid_license  = 'Kehtivat Rockstari litsentsi ei leitud',
        not_whitelisted = 'Te ei ole selle serveri jaoks Allowlisted',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Saite oma palga $%{value}',
        job_info = 'Töö: %{value} | Auaste: %{value2} | Tööpostil: %{value3}',
        gang_info = 'Gang: %{value} | Auaste: %{value2}',
        on_duty = 'Sa oled tööle kirjutatud!',
        off_duty = 'Sa kirjutasid ennast töölt vabaks!',
        join_server = 'Tere tulemast %s serverisse.',
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

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

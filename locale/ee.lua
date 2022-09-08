local Translations = {
    error = {
        not_online = 'Mängija pole serveris!',
        wrong_format = 'Vale formaat.',
        missing_args = 'Kõiki argumente pole sisestatud (x, y, z)',
        missing_args2 = 'Kõik argumendid tuleb täita!',
        no_access = 'Sellele käsule pole juurdepääsu!',
        company_too_poor = 'Teie tööandja on pankrotis.',
        item_not_exist = 'Sellist asja ei eksisteeri',
        too_heavy = 'Inventuur on liiga täis',
        duplicate_license = 'Leiti Rockstari litsentsi duplikaat',
        no_valid_license  = 'Kehtivat Rockstari litsentsi ei leitud',
        not_whitelisted = 'Te\'pole serveri Allowlistis!',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Saite oma töötasu kätte $%{value}',
        job_info = 'Töökoht: %{value} | Auaste: %{value2} | Tööl: %{value3}',
        gang_info = 'Gang: %{value} | Auaste: %{value2}',
        on_duty = 'Alustasite enda tööpäeva!',
        off_duty = 'Lõpetasite enda tööpäeva!',
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

if GetConvar('qb_locale', 'en') == 'ee' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

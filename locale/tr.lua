local Translations = {
    error = {
        not_online = 'Oyuncu çevrimiçi değil.',
        wrong_format = 'Yanlış format.',
        missing_args = 'Hiçbir argüman girilmedi. (x, y, z)',
        missing_args2 = 'Tüm argümanlar doldurulmalıdır.',
        no_access = 'Bu komuta erişimin yok.',
        company_too_poor = 'Şirketin hiç parası yok.',
        item_not_exist = 'Eşya mevcut değil.',
        too_heavy = 'Envanter çok dolu',
        duplicate_license = 'Aynı rockstar lisansı zaten şu an sunucuda!',
        no_valid_license  = 'Geçerli bir rockstar lisans bulunamadı.',
        not_whitelisted = 'Bu sunucuda whitelistin yok.',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = '$%{value} tutarında bir maaş çeki aldın.',
        job_info = 'İş: %{value} | Seviye: %{value2} | Görev: %{value3}',
        gang_info = 'Çete: %{value} | Seviye: %{value2}',
        on_duty = 'Mesaiye girdin.',
        off_duty = 'Mesaiden çıktın.',
        join_server = 'Merhaba %s. adlı sunucumuza hoş geldin.',
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

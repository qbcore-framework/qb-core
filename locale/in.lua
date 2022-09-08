local Translations = {
    error = {
        not_online = 'Pemain tidak online',
        wrong_format = 'Format salah',
        missing_args = 'Tidak semua argumen telah dimasukkan (x, y, z)',
        missing_args2 = 'Semua argumen harus diisi!',
        no_access = 'Tidak ada akses ke perintah ini',
        company_too_poor = 'Majikan kamu bangkrut',
        item_not_exist = 'Barang tidak tersedia',
        too_heavy = 'Inventory terlalu penuh',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Kamu menerima gaji kamu sebesar $%{value}',
        job_info = 'Pekerjaan: %{value} | Pangkat: %{value2} | Bertugas: %{value3}',
        gang_info = 'Gang: %{value} | Pangkat: %{value2}',
        on_duty = 'Kamu sekarang sedang bertugas!',
        off_duty = 'Kamu sekarang sedang tidak bertugas!',
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

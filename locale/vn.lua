local Translations = {
    error = {
        not_online = 'Người chơi không trực tuyến',
        wrong_format = 'Định dạng không chính xác',
        missing_args = 'chưa nhập đủ các số (x, y, z)',
        missing_args2 = 'Tất cả các đối số phải được điền vào!',
        no_access = 'không có quyền sử dụng lệnh này',
        company_too_poor = 'Công ty của bạn đã phá sản',
        item_not_exist = 'Vật phẩm không tồn tại',
        too_heavy = 'kho đồ đã đầy',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'bạn nhận được sốt tiền thanh toán là $%{value}',
        job_info = 'Công việc: %{value} | Cấp độ: %{value2} | Làm việc: %{value3}',
        gang_info = 'Băng đảng: %{value} | Cấp độ: %{value2}',
        on_duty = 'Bạn đã sẵn sàng làm viêc!',
        off_duty = 'Bạn đã dừng làm việc!',
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

if GetConvar('qb_locale', 'en') == 'vn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

local Translations = {
    error = {
        not_online = '玩家不在线',
        wrong_format = '格式错误',
        missing_args = '请输入必须参数 (x, y, z)',
        missing_args2 = '请输入所有参数!',
        no_access = '你没有权限',
        company_too_poor = '你所在的公司账户目前发不起工资',
        item_not_exist = '该物品不存在',
        too_heavy = '背包已满',
        duplicate_license = '发现重复的 Rockstar 许可证',
        no_valid_license  = '未找到有效的 Rockstar 许可证',
        not_whitelisted = '您没有被列入此服务器的白名单',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = '你收到了你的工资 $%{value}',
        job_info = '工作: %{value} | 级别: %{value2} | 工作状态状态: %{value3}',
        gang_info = '帮派: %{value} | 级别: %{value2}',
        on_duty = '你开始上班了!',
        off_duty = '你现在下班了!',
        join_server = '欢迎 %s 进入.',
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

if GetConvar('qb_locale', 'en') == 'cn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

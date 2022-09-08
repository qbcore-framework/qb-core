local Translations = {
    error = {
        not_online = 'Играчът не е онлайн',
        wrong_format = 'Некоректен формат',
        missing_args = 'Не всички аргументи са въведени (x, y, z)',
        missing_args2 = 'Всички аргументи трябва да бъдат попълнени!',
        no_access = 'Нямате достъп до тази команда',
        company_too_poor = 'Работодателят ви е разорен',
        item_not_exist = 'Артикулът не съществува',
        too_heavy = 'Ивентарът е препълнен',
        duplicate_license = 'Намерен е дубликат на Rockstar лиценза',
        no_valid_license  = 'Не е намерен валиден Rockstar лиценз',
        not_whitelisted = 'Вие не сте включени в белия списък за този сървър',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Получихте заплата от $%{value}',
        job_info = 'Работно място: %{value} | Чин: %{value2} | Служба: %{value3}',
        gang_info = 'Банда: %{value} | Чин: %{value2}',
        on_duty = 'Сега сте на служба!',
        off_duty = 'Вече не сте на служба!',
        checking_ban = 'Checking banned status... 🔨',
        checking_whitelisted = 'Checking whitelist status... 👑',
        checking_license_credentials = 'Checking license credentials... 📖',
        checking_license_duplicate = 'Checking for duplicate license... ⛓️',
        join_server = 'Добре дошли %s.',
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
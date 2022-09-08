local Translations = {
    error = {
        not_online = 'მოთამაშე ონლაინში არ არის',
        wrong_format = 'არასწორი ფორმატი',
        missing_args = 'ყველა არგუმენტი არ არის შეყვანილი (x, y, z)',
        missing_args2 = 'ყველა არგუმენტი უნდა იყოს შევსებული!',
        no_access = 'ამ ბრძანებაზე წვდომა არ არის',
        company_too_poor = 'თქვენი დამსაქმებელი ღარიბია',
        item_exist = 'ნივთი არ არსებობს',
        too_heavy = 'ზედმეტად სავსეა ინვენტარი',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'თქვენ მიიღეთ თქვენი ხელფასი $%{value}',
        job_info = 'სამუშაო: %{value} | შეფასება: %{value2} | მოვალეობა: %{value3}',
        gang_info = 'ჯგუფი: %{value} | შეფასება: %{value2}',
        on_duty = 'ახლა მორიგე ხარ!',
        off_duty = 'ახლა სამსახურიდან გასული ხარ!',
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

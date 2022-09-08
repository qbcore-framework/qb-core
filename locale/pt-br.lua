local Translations = {
    error = {
        not_online = 'O jogador não está online',
        wrong_format = 'Formato inválido',
        missing_args = 'Nem todos os argumentos foram inseridos (x, y, z)',
        missing_args2 = 'Todos os argumentos devem ser preenchidos!',
        no_access = 'Sem acesso a este comando',
        company_too_poor = 'Sua compania está quebrada',
        item_not_exist = 'O item não existe',
        too_heavy = 'Inventário cheio',
        duplicate_license = 'Licença duplicada da Rockstar encontrada',
        no_valid_license  = 'Nenhuma licença válida da Rockstar encontrada',
        not_whitelisted = 'Você não tem whitelist neste servidor',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Você recebeu seu salário de %{value}€',
        job_info = 'Emprego: %{value} | Grau: %{value2} | Serviço: %{value3}',
        gang_info = 'Gang: %{value} | Grau: %{value2}',
        on_duty = 'Você agora está de plantão!',
        off_duty = 'Você agora está de folga!',
        join_server = 'Bem-vindo %s a.',
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

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

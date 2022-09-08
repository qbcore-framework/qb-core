local Translations = {
    error = {
        not_online = 'O jogador não está online',
        wrong_format = 'Formato inválido',
        missing_args = 'Não introduziste todos os argumentos (x, y, z)',
        missing_args2 = 'Todos os argumentos têm de ser preenchidos!',
        no_access = 'Não tens acesso a este comando',
        company_too_poor = 'A tua empresa está falida',
        item_not_exist = 'O item não existe',
        too_heavy = 'Inventário cheio',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Recebeste o pagamento de %{value}€',
        job_info = 'Emprego: %{value} | Grau: %{value2} | Serviço: %{value3}',
        gang_info = 'Gang: %{value} | Grau: %{value2}',
        on_duty = 'Agora estás de serviço!',
        off_duty = 'Agora estás fora de serviço!',
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

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

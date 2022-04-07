local Translations = {
    error = {
        not_online = 'O jogador não está online',
        wrong_format = 'Formato inválido',
        missing_args = 'Não introduziste todos os argumentos (x, y, z)',
        missing_args2 = 'Todos os argumentos têm de ser preenchidos!',
        no_access = 'Não tens acesso a este comando',
        company_too_poor = 'A tua empresa está falida',
        item_not_exist = 'O item não existe',
        too_heavy = 'Inventário cheio'
    },
    success = {},
    info = {
        received_paycheck = 'Recebeste o pagamento de %{value}€',
        job_info = 'Emprego: %{value} | Grau: %{value2} | Serviço: %{value3}',
        gang_info = 'Gang: %{value} | Grau: %{value2}',
        on_duty = 'Agora estás de serviço!',
        off_duty = 'Agora estás fora de serviço!'
    }
}

--if not Lang then            --This test is only needed in locale en, please comment it on other languages

    local templocale = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        locale = "pt"
    }) 
    if templocale then
        Lang = templocale
    end
    
--end                         --Comment this line also
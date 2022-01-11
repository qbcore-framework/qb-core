local Translations = {
    error = {
        not_online = 'Jogador offline',
        wrong_format = 'Formato Incorreto',
        missing_args = 'Valores em falta (x, y, z)',
        missing_args2 = 'Todos os valores devem ser preenchidos!',
        no_access = 'Sem permissão para o comando',
        company_too_poor = 'O teu empregador está falido',
        item_not_exist = 'Item não existe',
        too_heavy = 'Excesso de carga'
    },
    success = {},
    info = {
        received_paycheck = 'Recebeste remuneração de €%{value}',
        job_info = 'Profissão: %{value} | Cargo: %{value2} | Turno: %{value3}',
        gang_info = 'Gang: %{value} | Cargo: %{value2}',
        on_duty = 'Iniciaste o turno!',
        off_duty = 'Terminaste o turno!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

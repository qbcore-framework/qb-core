local Translations = {
    error = {
        not_online = 'Player offline',
        wrong_format = 'Formato sbagliato',
        missing_args = 'Devi inserire ancora qualcosa(x, y, z)',
        missing_args2 = 'Tutti gli argomenti devono essere compilati!',
        no_access = 'Non hai accesso a questo comando',
        company_too_poor = 'La tua azienda è povera',
        item_not_exist = 'Oggetto inesistente',
        too_heavy = 'Inventario pieno'
    },
    success = {},
    info = {
        received_paycheck = 'Hai ricevuto la paga di $%{value}',
        job_info = 'Lavoro: %{value} | Grado: %{value2} | Stato: %{value3}',
        gang_info = 'Gang: %{value} | Grado: %{value2}',
        on_duty = 'Sei in servizio!',
        off_duty = 'Sei fuori servizio!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

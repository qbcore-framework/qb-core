local Translations = {
    error = {
        not_online = 'Jucatorul nu este conectat',
        wrong_format = 'Format incorect',
        missing_args = 'Nu ai introdus toate argumentele (x, y, z)',
        missing_args2 = 'Toate argumentele trebuie specificate!',
        no_access = 'Nu ai acces la aceasta comanda',
        company_too_poor = 'Seful tau este sarac si nu are bani pentru a te plati',
        item_not_exist = 'Item-ul nu exista',
        too_heavy = 'Inventarul este prea greu'
    },
    success = {},
    info = {
        received_paycheck = 'Ai primit salariul in valoare de: $%{value}',
        job_info = 'Job: %{value} | Statut: %{value2} | In Tura: %{value3}',
        gang_info = 'Gang: %{value} | Statut: %{value2}',
        on_duty = 'Ai intrat in tura!',
        off_duty = 'Ai iesit din tura!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

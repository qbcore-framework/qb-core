local Translations = {
    error = {
        not_online = 'Spieler nicht online',
        wrong_format = 'Falsches Format',
        missing_args = 'Nicht jedes Argument wurde angegeben (x, y, z)',
        missing_args2 = 'Alle Argumente müssen ausgefüllt werden!',
        no_access = 'Kein Zugriff auf diesen Befehl',
        company_too_poor = 'Dein Arbeitgeber ist pleite',
        item_not_exist = 'Gegenstand existiert nicht',
        too_heavy = 'Inventar ist zu voll!'
    },
    success = {},
    info = {
        received_paycheck = 'Du hast deinen Gehalt über $%{value} erhalten',
        job_info = 'Beruf: %{value} | Position: %{value2} | im Dienst: %{value3}',
        gang_info = 'Gang: %{value} | Position: %{value2}',
        on_duty = 'Du bist jetzt im Dienst!',
        off_duty = 'Du bist jetzt außer Dienst!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

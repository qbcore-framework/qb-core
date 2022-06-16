local Translations = {
    error = {
        not_online = 'Spieler nicht online',
        wrong_format = 'Falsches Format',
        missing_args = 'Nicht jedes Argument wurde angegeben (x, y, z)',
        missing_args2 = 'Alle Argumente müssen ausgefüllt werden!',
        no_access = 'Kein Zugriff auf diesen Befehl',
        company_too_poor = 'Dein Arbeitgeber ist pleite',
        item_not_exist = 'Item existiert nicht',
        too_heavy = 'Inventar zu voll',
        duplicate_license = 'Doppelte Rockstar-Lizenz gefunden',
        no_valid_license  = 'Keine gültige Rockstar-Lizenz gefunden',
        not_whitelisted = 'Du bist nicht gewhitelistet für diesen Server'
    },
    success = {},
    info = {
        received_paycheck = 'Du hast deinen Gehalt über $%{value} erhalten',
        job_info = 'Beruf: %{value} | Dienstgrad: %{value2} | im Dienst: %{value3}',
        gang_info = 'Gang: %{value} | Rang: %{value2}',
        on_duty = 'Du bist jetzt im Dienst!',
        off_duty = 'Du bist jetzt außer Dienst!',
        checking_ban = 'Hallo %s. Wir prüfen gerade, ob du gebannt bist.',
        join_server = 'Willkommen %s bei {Server Name}.',
        checking_whitelisted = 'Hallo %s. Wir überprüfen gerade deine Erlaubnis.'
    }
}

--if not Lang then            --This test is only needed in locale en, please comment it on other languages

    local templocale = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        locale = "de"
    }) 
    if templocale then
        Lang = templocale
    end
    
--end                         --Comment this line also
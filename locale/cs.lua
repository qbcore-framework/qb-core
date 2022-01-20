local Translations = {
    error = {
        not_online = 'Hráč není online',
        wrong_format = 'Nesprávný formát',
        missing_args = 'Nebyl zadán správný formát (x, y, z)',
        missing_args2 = 'Je nutno vyplnit vše!',
        no_access = 'K tomuto přikazu nemáte přistup!',
        company_too_poor = 'Firma nemá peníze!',
        item_not_exist = 'Předmět neexistuje!',
        too_heavy = 'Plný inventář, víc neuneseš!'
    },
    success = {},
    info = {
        received_paycheck = 'Dostali jste svou výplatu $%{value}',
        job_info = 'Zaměstnán u: %{value} | Pozice: %{value2} | Ve službě: %{value3}',
        gang_info = 'Gang: %{value} | Pozice: %{value2}',
        on_duty = 'Nyní jste ve službě!',
        off_duty = 'Nyní jste mimo službu!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
    error = {
        not_online = 'Hráč není online',
        wrong_format = 'Nesprávný formát',
        missing_args = 'Né všechny argumenty byly vyplněny (x, y, z)',
        missing_args2 = 'Všechny argumenty musí být vyplněný!',
        no_access = 'Nemáte přístup k tomuto příkazu',
        company_too_poor = 'Váš zaměstnavatel nemá dostatek peněz, aby vás vyplatil',
        item_not_exist = 'Předmět neexistuje',
        too_heavy = 'Inventář je plný',
        duplicate_license = 'Stejná Rockstar licence je již na serveru',
        no_valid_license  = 'Nebyla nalezena žádná platná Rockstar licence',
        not_whitelisted = 'Nejste na whitelistu'
    },
    success = {},
    info = {
        received_paycheck = 'Obdrželi jste výplatu v hodnotě $%{value}',
        job_info = 'Práce: %{value} | Pozice: %{value2} | Ve službě: %{value3}',
        gang_info = 'Gang: %{value} | Pozice: %{value2}',
        on_duty = 'Vešli jste do služby',
        off_duty = 'Odešli jste ze služby!',
        checking_ban = 'Ahoj %s. Kontrolujeme zda nejste zabanováni.',
        join_server = 'Vítejte %s na {Server Name}.',
        checking_whitelisted = 'Ahoj %s. Kontrolujeme zda máte přístup.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

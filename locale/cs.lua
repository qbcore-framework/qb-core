local Translations = {
    error = {
        not_online = 'Hráč není online',
        wrong_format = 'Nesprávný formát',
        missing_args = 'Nebyla zadána každá hodnota (x, y, z)',
        missing_args2 = 'Všechny hodnoty musí být vyplněny!',
        no_access = 'K tomuto příkazu nemáte přístup',
        company_too_poor = 'Váš zaměstnavatel nemá dostatek peněz',
        item_not_exist = 'Item neexistuje',
        too_heavy = 'Inventář je plný'
    },
    success = {},
    info = {
        received_paycheck = 'Obdržel jsi výplatu ve výši $%{value}',
        job_info = 'Práce: %{value} | Pozice: %{value2} | Stav: %{value3}',
        gang_info = 'Gang: %{value} | Pozice: %{value2}',
        on_duty = 'Nyní jsi ve službe!',
        off_duty = 'Již nejsi ve službě!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

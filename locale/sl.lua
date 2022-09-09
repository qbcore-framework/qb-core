local Translations = {
    error = {
        not_online = 'Igralec ni online',
        wrong_format = 'Napacen format',
        missing_args = 'Nekateri argumenti niso bili vpisani (x, y, z)',
        missing_args2 = 'Vsi argumenti morajo biti vpisani!',
        no_access = 'Nimas dostopa do te komande!',
        company_too_poor = 'Tvoj delodajalec nima denarja',
        item_not_exist = 'Predmet ne obstaja',
        too_heavy = 'Tvoj inventorij je prevec poln'
    },
    success = {},
    info = {
        received_paycheck = 'Prejel si placilo $%{value}',
        job_info = 'Sluzba: %{value} | Rang: %{value2} | Dolznost: %{value3}',
        gang_info = 'Tolpa: %{value} | Rang: %{value2}',
        on_duty = 'Sedaj si na dolznosti!',
        off_duty = 'Nisi vec na dolznosti!'
    }
}

if GetConvar('qb_locale', 'en') == 'sl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

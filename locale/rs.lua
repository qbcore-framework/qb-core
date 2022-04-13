local Translations = {
    error = {
        not_online = 'Igrac nije online',
        wrong_format = 'Netacan format',
        missing_args = 'Nije unet svaki argument (x, y, z)',
        missing_args2 = 'Svi argumenti moraju biti popunjeni!',
        no_access = 'Nemate pristup ovoj komandi',
        company_too_poor = 'Vas poslodavac nema para',
        item_not_exist = 'Stavka ne postoji',
        too_heavy = 'Inventar je prepun'
    },
    success = {},
    info = {
        received_paycheck = 'Dobili ste platu u iznosu od $%{value}',
        job_info = 'Posao: %{value} | Rank: %{value2} | Duznost: %{value3}',
        gang_info = 'Banda: %{value} | Rank: %{value2}',
        on_duty = 'Sada ste na duznosti!',
        off_duty = 'Sada ste van duznosti!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
    error = {
        not_online = 'Mängija pole serveris!',
        wrong_format = 'Vale formaat.',
        missing_args = 'Kõiki argumente pole sisestatud (x, y, z)',
        missing_args2 = 'Kõik argumendid tuleb täita!',
        no_access = 'Sellele käsule pole juurdepääsu!',
        company_too_poor = 'Teie tööandja on pankrotis.',
        item_not_exist = 'Sellist asja ei eksisteeri',
        too_heavy = 'Inventuur on liiga täis',
        duplicate_license = 'Leiti Rockstari litsentsi duplikaat',
        no_valid_license  = 'Kehtivat Rockstari litsentsi ei leitud',
        not_whitelisted = 'Te\'pole serveri Allowlistis!'
    },
    success = {},
    info = {
        received_paycheck = 'Saite oma töötasu kätte $%{value}',
        job_info = 'Töökoht: %{value} | Auaste: %{value2} | Tööl: %{value3}',
        gang_info = 'Gang: %{value} | Auaste: %{value2}',
        on_duty = 'Alustasite enda tööpäeva!',
        off_duty = 'Lõpetasite enda tööpäeva!',
        checking_ban = 'Tere %s. Me kontrollime, kas olete keelustatud.',
        join_server = 'Tere tulemast %s serverisse {Server Name}.',
        checking_whitelisted = 'Tere %s. Kontrollime teie Allowlisti olemasolu.'
    }
}

if GetConvar('qb_locale', 'en') == 'ee' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

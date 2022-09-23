local Translations = {
    error = {
        not_online = 'Player online nist !',
        wrong_format = 'Vorodi sahih nist !',
        missing_args = 'Vorodi naghes ast (x, y, z)',
        missing_args2 = 'Tamam vorodi hara vared konid !',
        no_access = 'Shoma dastresi nadarid !',
        company_too_poor = 'Sherkat shoma, pul kafi baraye hoghogh dadan nadarad !',
        item_not_exist = 'In item vojod nadarad',
        too_heavy = 'Inventory kheyli sangin ast !'
    },
    success = {},
    info = {
        received_paycheck = 'Hoghogh shoma variz shod : $%{value}',
        job_info = 'Shoghl: %{value} | Daraje: %{value2} | Dar hal kar: %{value3}',
        gang_info = 'Gang: %{value} | Daraje: %{value2}',
        on_duty = 'Shoma dar hal kar hastid (on-duty)!',
        off_duty = 'Shoma az kar kharej shodid (off-duty)!'
    }
}

if GetConvar('qb_locale', 'en') == 'fa' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

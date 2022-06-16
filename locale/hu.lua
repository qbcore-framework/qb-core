local Translations = {
    error = {
        not_online = 'A játékos nem elérhető',
        wrong_format = 'Helytelen formátum',
        missing_args = 'Nem minden érték lett megadva (x, y, z)',
        missing_args2 = 'Az összes értéket meg kell adnod!',
        no_access = 'Nem használhatod ezt a parancsot',
        company_too_poor = 'A munkáltatód nem tudott kifizetni',
        item_not_exist = 'Ez a tárgy nem létezik',
        too_heavy = 'A leltárad megtelt'
    },
    success = {},
    info = {
        received_paycheck = 'Megérkezett a fizetésed: %{value}$',
        job_info = 'Munka: %{value} | Szint: %{value2} | Szolgálatban: %{value3}',
        gang_info = 'Banda: %{value} | Szint: %{value2}',
        on_duty = 'Mostantól szolgálatban vagy!',
        off_duty = 'Mostantól nem vagy szolgálatban!'
    }
}

--if not Lang then            --This test is only needed in locale en, please comment it on other languages

    local templocale = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        locale = "hu"
    })
    if templocale then
        Lang = templocale
    end

--end                         --Comment this line also

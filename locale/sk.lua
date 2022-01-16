local Translations = {
    error = {
        not_online = 'Hráč nie je online',
        wrong_format = 'Nesprávny formát',
        missing_args = 'Nezadal si všetky argumenty (x, y, z)',
        missing_args2 = 'Všetky argumenty musia byť vyplnené!',
        no_access = 'Nemáš prístup k tomuto príkazu',
        company_too_poor = 'Váš zamestnávateľ má problémy',
        item_not_exist = 'Tento Item neexistuje',
        too_heavy = 'Tvoj inventár je plný'
    },
    success = {},
    info = {
        received_paycheck = 'Dostali ste výplatu v hodnote $%{value}',
        job_info = 'Práca: %{value} | Postavenie: %{value2} | Služba: %{value3}',
        gang_info = 'Gang: %{value} | Postavenie: %{value2}',
        on_duty = 'Prišli ste do služby!',
        off_duty = 'Išli ste mimo službu!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

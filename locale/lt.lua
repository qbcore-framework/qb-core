local Translations = {
    error = {
        not_online = 'Žaidėjas neprisijungęs',
        wrong_format = 'Neteisingas formatas',
        missing_args = 'Ne visi argumentai buvo įvesti (x, y, z)',
        missing_args2 = 'Visi argumentai privalo būti įvesti!',
        no_access = 'Nėra leidimo šiai komandai',
        company_too_poor = 'Jūsų darbovietė žlugusi',
        item_not_exist = 'Daiktas neegzistuoja',
        too_heavy = 'Inventorius pilnas',
        location_not_exist = 'Vieta neegzistuoja',
        duplicate_license = 'Rasta dublikuota Rockstar licensija',
        no_valid_license  = 'Nerasta veikianti Rockstar licensija',
        not_whitelisted = 'Jūs nesate šio serverio baltajame sąraše',
        server_already_open = 'Serveris jau atidarytas',
        server_already_closed = 'Serveris jau uždarytas',
        no_permission = 'Jūs neturite leidimo tam...',
        no_waypoint = 'Nebuvo nustatytas norimas taškas.',
        tp_error = 'Klaida teleportuojantis.',
    },
    success = {
        server_opened = 'Serveris buvo atidarytas',
        server_closed = 'Serveris buvo uždarytas',
        teleported_waypoint = 'Nusiteleportavote į norimą tašką.',
    },
    info = {
        received_paycheck = 'Jūs gavote atlyginimą $%{value}',
        job_info = 'Darbas: %{value} | Laipsnis: %{value2} | Darbe: %{value3}',
        gang_info = 'Gauja: %{value} | Laipsnis: %{value2}',
        on_duty = 'Jūs atėjote į darbą!',
        off_duty = 'Jūs išėjote iš darbo!',
        checking_ban = 'Sveiki, %s. Mes tikriname, ar nesate užblokuotas.',
        join_server = 'Sveiki atvykę, %s, į {Server Name}.',
        checking_whitelisted = 'Sveiki, %s. Mes tikriname jūsų leidimus.',
        exploit_banned = 'Jūs buvote užblokuotas už sukčiavimą. Apsilankykite mūsų Discord, dėl platesnės informacijos: %{discord}',
        exploit_dropped = 'Jūs buvote išmestas už klaidų išnaudojimą',
    },
    command = {
        tp = {
            help = 'Teleportuotis pas žaidėją arba į koordinates (Tik administratoriams)',
            params = {
                x = { name = 'id/x', help = 'Žaidėjo ID arba X pozicija'},
                y = { name = 'y', help = 'Y pozicija'},
                z = { name = 'z', help = 'Z pozicija'},
            },
        },
        tpm = { help = 'Teleportuotis į pažymėtą vietą (Tik administratoriams)' },
        togglepvp = { help = 'Toggle PVP on the server (Tik administratoriams)' },
        addpermission = {
            help = 'Duoti žaidėjui leidimus (Tik dievams)',
            params = {
                id = { name = 'id', help = 'Žaidėjo ID' },
                permission = { name = 'permission', help = 'Leidimų lygis' },
            },
        },
        removepermission = {
            help = 'Panaikinti žaidėjo leidimus (Tik dievams)',
            params = {
                id = { name = 'id', help = 'Žaidėjo ID' },
                permission = { name = 'permission', help = 'Leidimų lygis' },
            },
        },
        openserver = { help = 'Atidaryti serverį visiems (Tik administratoriams)' },
        closeserver = {
            help = 'Uždaryti serverį žmonėms kurie neturi leidimų (Tik administratoriams)',
            params = {
                reason = { name = 'reason', help = 'Uždarymo priežastis (pasirinktinai)' },
            },
        },
        car = {
            help = 'Iškviesti transporto priemonę (Tik administratoriams)',
            params = {
                model = { name = 'model', help = 'Transporto priemonės modelio pavadinimas' },
            },
        },
        dv = { help = 'Ištrinti transporto priemonę (Tik administratoriams)' },
        givemoney = {
            help = 'Duoti žaidėjui pinigų (Tik administratoriams)',
            params = {
                id = { name = 'id', help = 'Žaidėjo ID' },
                moneytype = { name = 'moneytype', help = 'Pinigų tipas (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Pinigų suma' },
            },
        },
        setmoney = {
            help = 'Nustatyti žaidėjo pinigų sumą (Tik administratoriams)',
            params = {
                id = { name = 'id', help = 'Žaidėjo ID' },
                moneytype = { name = 'moneytype', help = 'Pinigų tipas (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Pinigų suma' },
            },
        },
        job = { help = 'Patikrinti savo darbą' },
        setjob = {
            help = 'Nustatyti žaidėjo darbą (Tik administratoriams)',
            params = {
                id = { name = 'id', help = 'Žaidėjo ID' },
                job = { name = 'job', help = 'Darbo pavadinimas' },
                grade = { name = 'grade', help = 'Darbo laipsnis' },
            },
        },
        gang = { help = 'Patikrinti savo gaują' },
        setgang = {
            help = 'Nustatyti žaidėjo gaują (Tik administratoriams)',
            params = {
                id = { name = 'id', help = 'Žaidėjo ID' },
                gang = { name = 'gang', help = 'Gaujos pavadinimas' },
                grade = { name = 'grade', help = 'Gaujos laipsnis' },
            },
        },
        ooc = { help = 'OOC žinutė' },
        me = {
            help = 'Rodyti vietines žinutes',
            params = {
                message = { name = 'message', help = 'Žinutė išsiuntimui' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'lt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

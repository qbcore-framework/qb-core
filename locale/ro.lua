--[[
Romanian base language translation for qb-core
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    error = {
        not_online = 'Jucătorul nu este online',
        wrong_format = 'Format incorect',
        missing_args = 'Nu au fost introduse toate argumentele (x, y, z)',
        missing_args2 = 'Trebuie completate toate argumentele!',
        no_access = 'Nu ai acces la această comandă',
        company_too_poor = 'Angajatorul tău este falit',
        item_not_exist = 'Obiectul nu există',
        too_heavy = 'Inventarul este prea plin',
        location_not_exist = 'Locația nu există',
        duplicate_license = 'Duplicate Rockstar License Found',
        no_valid_license  = 'Nicio licență Rockstar validă găsită',
        not_whitelisted = 'Nu ești în lista albă pentru acest server',
        server_already_open = 'Serverul este deja deschis',
        server_already_closed = 'Serverul este deja închis',
        no_permission = 'Nu ai permisiuni pentru asta..',
        no_waypoint = 'Nu a fost setat un punct de referință.',
        tp_error = 'Eroare în timpul teleportării.',
        connecting_database_error = 'A apărut o eroare de bază de date în timpul conectării la server. (Este serverul SQL pornit?)',
        connecting_database_timeout = 'Conexiunea la baza de date a expirat. (Este serverul SQL pornit?)',
    },
    success = {
        server_opened = 'Serverul a fost deschis',
        server_closed = 'Serverul a fost închis',
        teleported_waypoint = 'Teleportat la punctul de referință.',
    },
    info = {
        received_paycheck = 'Ai primit salariul în valoare de $%{value}',
        job_info = 'Job: %{value} | Grad: %{value2} | Îndatorire: %{value3}',
        gang_info = 'Bandă: %{value} | Grad: %{value2}',
        on_duty = 'Ești în serviciu acum!',
        off_duty = 'Nu ești în serviciu acum!',
        checking_ban = 'Salut %s. Verificăm dacă ești interzis.',
        join_server = 'Bun venit %s pe {Numele Serverului}.',
        checking_whitelisted = 'Salut %s. Verificăm aprobarea ta.',
        exploit_banned = 'Ai fost interzis pentru înșelăciune. Verifică Discord-ul nostru pentru mai multe informații: %{discord}',
        exploit_dropped = 'Ai fost dat afară pentru exploatare',
    },
    command = {
        tp = {
            help = 'Teleportează la un jucător sau coordonate (doar pentru administrator)',
            params = {
                x = { name = 'id/x', help = 'ID-ul jucătorului sau poziția X' },
                y = { name = 'y', help = 'Poziția Y' },
                z = { name = 'z', help = 'Poziția Z' },
            },
        },
        tpm = { help = 'Teleportează la marker (doar pentru administrator)' },
        togglepvp = { help = 'Activează/dezactivează PVP pe server (doar pentru administrator)' },
        addpermission = {
            help = 'Acordă permisiuni jucătorului (doar pentru creator)',
            params = {
                id = { name = 'id', help = 'ID-ul jucătorului' },
                permission = { name = 'permission', help = 'Nivelul permisiunii' },
            },
        },
        removepermission = {
            help = 'Elimină permisiunile jucătorului (doar pentru creator)',
            params = {
                id = { name = 'id', help = 'ID-ul jucătorului' },
                permission = { name = 'permission', help = 'Nivelul permisiunii' },
            },
        },
        openserver = { help = 'Deschide serverul pentru toți (doar pentru administrator)' },
        closeserver = {
            help = 'Închide serverul pentru persoanele fără permisiuni (doar pentru administrator)',
            params = {
                reason = { name = 'reason', help = 'Motivul închiderii (opțional)' },
            },
        },
        car = {
            help = 'Generează vehicul (doar pentru administrator)',
            params = {
                model = { name = 'model', help = 'Numele modelului vehiculului' },
            },
        },
        dv = { help = 'Șterge vehicul (doar pentru administrator)' },
        givemoney = {
            help = 'Dă bani unui jucător (doar pentru administrator)',
            params = {
                id = { name = 'id', help = 'ID-ul jucătorului' },
                moneytype = { name = 'moneytype', help = 'Tipul de bani (cash, bancă, criptomonede)' },
                amount = { name = 'amount', help = 'Suma de bani' },
            },
        },
        setmoney = {
            help = 'Setează suma de bani a unui jucător (doar pentru administrator)',
            params = {
                id = { name = 'id', help = 'ID-ul jucătorului' },
                moneytype = { name = 'moneytype', help = 'Tipul de bani (cash, bancă, criptomonede)' },
                amount = { name = 'amount', help = 'Suma de bani' },
            },
        },
        job = { help = 'Verifică-ți jobul' },
        setjob = {
            help = 'Setează jobul unui jucător (doar pentru administrator)',
            params = {
                id = { name = 'id', help = 'ID-ul jucătorului' },
                job = { name = 'job', help = 'Numele jobului' },
                grade = { name = 'grade', help = 'Gradul jobului' },
            },
        },
        gang = { help = 'Verifică-ți banda' },
        setgang = {
            help = 'Setează banda unui jucător (doar pentru administrator)',
            params = {
                id = { name = 'id', help = 'ID-ul jucătorului' },
                gang = { name = 'gang', help = 'Numele băndei' },
                grade = { name = 'grade', help = 'Gradul băndei' },
            },
        },
        ooc = { help = 'Mesaj chat OOC' },
        me = {
            help = 'Afișează un mesaj local',
            params = {
                message = { name = 'message', help = 'Mesajul de trimis' }
            },
        },
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

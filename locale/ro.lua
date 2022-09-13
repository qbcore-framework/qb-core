--[[
Romanian base language translation for qb-core
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    error = {
        not_online = 'Cetateanul nu este in stat (offline)',
        wrong_format = 'Format incorect',
        missing_args = 'Nu ai pferit toate argumentele necesare (x, y, z)',
        missing_args2 = 'Toate argumentele trebuiesc precizate!',
        no_access = 'Nu ai acces la aceasta comanda!',
        company_too_poor = 'Patronul tau e sarachie mare, nu are bani!',
        item_not_exist = 'Acest obiect nu exista',
        too_heavy = 'Inventarul tau este prea plin',
        duplicate_license = 'Duplicat de licenta RockStar detectata',
        no_valid_license  = 'Nu s-a gasit nicio licenta valida RockStar',
        not_whitelisted = 'Nu ai statut de whitelist pe acest server',
        no_permission = 'Din pacate nu ai permisiunile necesare pentru asa ceva..',
        no_waypoint = 'Niciun punct de referinta setat.',
        tp_error = 'A aparut o eroare la teleportare.',
    },
    success = {
        teleported_waypoint = 'Ai fost teleportat la punctul de referinta.',
    },
    info = {
        received_paycheck = 'Ai primit salariul in valoare de $%{value}',
        job_info = 'Job: %{value} | Functie: %{value2} | In tura: %{value3}',
        gang_info = 'Gasca: %{value} | Functie: %{value2}',
        on_duty = 'Ai inceput tura !',
        off_duty = 'Ai iesit din tura!',
        checking_ban = 'Salutari %s. Verificam daca ai primit ban la noi :)',
        join_server = 'Bun venit %s pe {Server Name}.',
        checking_whitelisted = 'Salutari %s. Iti facem o verificare scurta.',
        exploit_banned = 'Ai fost banat pentru cheating. Informatii suplimentare pe serverul nostru de Discord: ',
        exploit_dropped = 'Ai primit KICK pentru ca ai incercat un exploit!',
    },
    command = {
        tp = {
            help = 'TP catre un jucator sau catre anumite coordonate (Admin Only)',
            params = {
                x = { name = 'ID/X', help = 'ID-ul jucatorului sau coordonata X'},
                y = { name = 'Y', help = 'Coordonata Y'},
                z = { name = 'Z', help = 'Coordonata Z'},
            },
        },
        tpm = { help = 'TP la punctul de referinta de pe harta (Admin Only)' },
        togglepvp = { help = 'Activeaza/Dezactiveaza PVP pe server (Admin Only)' },
        addpermission = {
            help = 'Dai permisiuni speciale unui jucator (God Only)',
            params = {
                id = { name = 'ID', help = 'ID-ul jucatorului' },
                permission = { name = 'Permisiuni', help = 'Permisiunile pe care vrei sa le dau (admin/moderator)' },
            },
        },
        removepermission = {
            help = 'Stergi permisiunile speciale ale unui jucator (God Only)',
            params = {
                id = { name = 'ID', help = 'ID-ul jucatorului' },
                permission = { name = 'Permisiuni', help = 'Nivelul de permisiuni pe care vrei sa le stergi' },
            },
        },
        openserver = { help = 'Deschide serverul pentru publicul larg (Admin Only)' },
        closeserver = {
            help = 'Inchide serverul pentru publicul larg (Admin Only)',
            params = {
                reason = { name = 'Motivul', help = 'Motivul pentru care serverul este inchis publicului larg (optional)' },
            },
        },
        car = {
            help = 'Spawneaza un vehicul (Admin Only)',
            params = {
                model = { name = 'Model', help = 'Modelul vehiculului dorit, Ex: intruder' },
            },
        },
        dv = { help = 'Stergi un vehicul (Admin Only)' },
        givemoney = {
            help = 'Dai o suma de bani unui jucator (Admin Only)',
            params = {
                id = { name = 'ID', help = 'ID-ul jucatorului, Ex: 342' },
                moneytype = { name = 'Tipul banilor', help = 'Aici avem 3 optiuni (cash, bank, crypto)' },
                amount = { name = 'Suma', help = 'Suma de bani pe care vrei sa o dai, Ex: 5000' },
            },
        },
        setmoney = {
            help = 'Setezi o suma de bani pentru un jucator anume (Admin Only)',
            params = {
                id = { name = 'ID', help = 'ID-ul Jucatorului' },
                moneytype = { name = 'tipul de bani', help = 'Tipul de bani pe care vrei sa-l setezi jucatorului (cash, bank, crypto)' },
                amount = { name = 'Suma', help = 'Suma de bani pe care vrei sa o dai/setezi' },
            },
        },
        job = { help = 'Iti verifici job-ul, in cazul in care ai uitat :)' },
        setjob = {
            help = 'Setezi un job pentru un cetatean (Admin Only)',
            params = {
                id = { name = 'ID', help = 'ID-ul Jucatorului' },
                job = { name = 'job', help = 'Numele jobului, asa cum este definit in config.' },
                grade = { name = 'Functia', help = 'Functia este de tipul 1,2,3,4 etc.' },
            },
        },
        setgang = {
            help = 'Setezi o gasca/mafie pentru un jucator (Admin Only)',
            params = {
                id = { name = 'ID', help = 'ID-ul Jucatorului' },
                gang = { name = 'gasca/mafie', help = 'Numele mafiei sau a gasti pe care vrei sa o setezi' },
                grade = { name = 'Functia', help = 'Functia este de tipul 1,2,3,4 etc.' },
            },
        },
        me = {
            help = 'Mesaj local/Indica o actiune sau afectiune',
            params = {
                message = { name = 'mesaj', help = 'Efectiv mesajul pe care vrei sa-l afisezi' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

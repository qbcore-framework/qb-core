local Translations = {
    error = {
        not_online = 'Igrač nije na mreži',
        wrong_format = 'Netačan format',
        missing_args = 'Nije unesen svaki argument (X, Y, Z)',
        missing_args2 = 'Svi argumenti moraju se popuniti!',
        no_access = 'Nemate pristupa ovoj komandi',
        company_too_poor = 'Vaš poslodavac je siromašan',
        item_not_exist = 'Predmet ne postoji',
        too_heavy = 'Inventar je prepun',
        location_not_exist = 'Lokacija ne postoji',
        duplicate_license = 'Duplicirana Rockstar licenca pronađena',
        no_valid_license  = 'Nije pronađena nijedna važeća Rockstar licenca',
        not_whitelisted = 'Niste na listi za čekanje na ovom serveru',
        server_already_open = 'Server je već otvoren',
        server_already_closed = 'Server je već zatvoren',
        no_permission = 'Nemate dozvole za ovo..',
        no_waypoint = 'Nema postavljen marker.',
        tp_error = 'Greška tokom teleportiranja.',
        connecting_database_error = 'Došlo je do pogreške u bazi podataka tokom povezivanja na serverom. (Je li SQL server uključen?)',
        connecting_database_timeout = 'Veza sa bazom podataka istekla. (Je li SQL server uključen?)',
    },
    success = {
        server_opened = 'Server je otvoren',
        server_closed = 'Server je zatvoren',
        teleported_waypoint = 'Teleportirani ste na marker.',
    },
    info = {
        received_paycheck = 'Primili ste platu od $%{value}',
        job_info = 'Posao: %{value} | Nivo: %{value2} | Dužnost: %{value3}',
        gang_info = 'Banda: %{value} | Nivo: %{value2}',
        on_duty = 'Sada ste na dužnosti!',
        off_duty = 'Sada ste izvan dužnosti!',
        checking_ban = 'Zdravo %s. Provjeravamo da li ste banovani.',
        join_server = 'Dobrodošli %s, na {Server Name}.',
        checking_whitelisted = 'Zdravo %s. Provjeravamo listu za čekanje.',
        exploit_banned = 'Banovani ste zbog varanja. Provjerite naš discord za više informacija: %{discord}',
        exploit_dropped = 'Banovani ste zbog eksplotacije',
    },
    command = {
        tp = {
            help = 'TP igraču ili koordinatama (Samo Admin)',
            params = {
                x = { name = 'id/x', help = 'ID igrača ili X kordinata'},
                y = { name = 'y', help = 'Y kordinata'},
                z = { name = 'z', help = 'Z kordinata'},
            },
        },
        tpm = { help = 'TP na Marker (Samo Admin)' },
        togglepvp = { help = 'Uključivanje PVP na serveru (Samo Admin)' },
        addpermission = {
            help = 'Dajte dozvole igraču (Samo God)',
            params = {
                id = { name = 'id', help = 'ID igrača' },
                permission = { name = 'permission', help = 'Nivo dozvole' },
            },
        },
        removepermission = {
            help = 'Uklonite dozvole igraču (Samo God)',
            params = {
                id = { name = 'id', help = 'ID igrača' },
                permission = { name = 'permission', help = 'Nivo dozvole' },
            },
        },
        openserver = { help = 'Otvorite server za sve (Samo Admin)' },
        closeserver = {
            help = 'Zatvorite server za ljude bez dozvola (Samo Admin)',
            params = {
                reason = { name = 'reason', help = 'Razlog zatvaranja (neobavezno)' },
            },
        },
        car = {
            help = 'Stvorite vozilo (Samo Admin)',
            params = {
                model = { name = 'model', help = 'Naziv modela vozila' },
            },
        },
        dv = { help = 'Izbrišite vozilo (Samo Admin)' },
        givemoney = {
            help = 'Dajte novac igraču (Samo Admin)',
            params = {
                id = { name = 'id', help = 'ID igrača' },
                moneytype = { name = 'moneytype', help = 'Vrsta novca (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Količina novca' },
            },
        },
        setmoney = {
            help = 'Podesite novac igraču (Samo Admin)',
            params = {
                id = { name = 'id', help = 'ID igrača' },
                moneytype = { name = 'moneytype', help = 'Vrsta novca (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Količina novca' },
            },
        },
        job = { help = 'Provjerite svoj posao' },
        setjob = {
            help = 'Podesite posao igraču (Samo Admin)',
            params = {
                id = { name = 'id', help = 'ID igrača' },
                job = { name = 'job', help = 'Ime posla' },
                grade = { name = 'grade', help = 'Nivo posla' },
            },
        },
        gang = { help = 'Provjerite svoju bandu' },
        setgang = {
            help = 'Postavite bandu igraču (Samo Admin)',
            params = {
                id = { name = 'id', help = 'ID igrača' },
                gang = { name = 'gang', help = 'Ime bande' },
                grade = { name = 'grade', help = 'Nivo bande' },
            },
        },
        ooc = { help = 'OOC Chat Poruka' },
        me = {
            help = 'Prikaži lokalnu poruku',
            params = {
                message = { name = 'message', help = 'Poruka za slanje' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'bs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
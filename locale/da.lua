local Translations = {
    error = {
        not_online = 'Spiller ikke online',
        wrong_format = 'Forkert format',
        missing_args = 'Du mangler nogle argumenter (x, y, z)',
        missing_args2 = 'Alle argumenter skal udfyldes!',
        no_access = 'Ingen adgang til denne kommando',
        company_too_poor = 'Din arbejdsgiver er for fattig',
        item_not_exist = 'Item findes ikke',
        too_heavy = 'Tasken er fuld',
        location_not_exist = 'Placering findes ikke',
        duplicate_license = 'Dublet Rockstar-licens fundet',
        no_valid_license  = 'Ingen gyldig Rockstar-licens fundet',
        not_whitelisted = 'Du er ikke allowlisted på denne server',
        server_already_open = 'Serveren er allerede åben',
        server_already_closed = 'Serveren er allerede lukket',
        no_permission = 'Du har ikke tilladelser til dette..',
        no_waypoint = 'Intet waypoint indstillet.',
        tp_error = 'Fejl under teleportering.',
        connecting_database_error = 'Der opstod en databasefejl under forbindelse til serveren. (Er SQL-serveren tændt?)',
        connecting_database_timeout = 'Forbindelsen til databasen fik timeout. (Er SQL-serveren tændt?)',
    },
    success = {
        server_opened = 'Serveren er blevet åbnet',
        server_closed = 'Serveren er blevet lukket',
        teleported_waypoint = 'Teleporteret til waypoint.',
    },
    info = {
        received_paycheck = 'Du har modtaget din lønseddel på %{value} kr.',
        job_info = 'Job: %{value} | Karakter: %{value2} | På Arbejde: ​​%{value3}',
        gang_info = 'Bande: %{value} | Karakter: %{value2}',
        on_duty = 'Du er nu på vagt!',
        off_duty = 'Du har nu fri!',
        checking_ban = 'Hej %s. Vi tjekker om du er bannet.',
        join_server = 'Velkommen %s til {Server Name}.',
        checking_whitelisted = 'Hej %s. Vi tjekker din godtgørelse.',
        exploit_banned = 'Du er blevet udelukket for exploit. Tjek vores Discord for mere information: %{discord}',
        exploit_dropped = 'Du er blevet sparket for exploit',
    },
    command = {
        tp = {
            help = 'TP til spiller eller koordinater (kun admin)',
            params = {
                x = { name = 'id/x', help = 'ID for spiller eller X-position'},
                y = { name = 'y', help = 'Y position'},
                z = { name = 'z', help = 'Z position'},
            },
        },
        tpm = { help = 'TP til markør (kun admin)' },
        togglepvp = { help = 'Slå PVP til/fra på serveren (kun admin)' },
        addpermission = {
            help = 'Giv spillertilladelser (kun gud)',
            params = {
                id = { name = 'id', help = 'ID på spiller' },
                permission = { name = 'tilladelse', help = 'Tilladelsesniveau' },
            },
        },
        removepermission = {
            help = 'Fjern spillertilladelser (kun gud)',
            params = {
                id = { name = 'id', help = 'ID på spiller' },
                permission = { name = 'tilladelse', help = 'Tilladelsesniveau' },
            },
        },
        openserver = { help = 'Åbn serveren for alle (kun admin)' },
        closeserver = {
            help = 'Luk serveren for personer uden tilladelser (kun administrator)',
            params = {
                reason = { name = 'årsag', help = 'Årsag til lukning (valgfrit)' },
            },
        },
        car = {
            help = 'Spawn-køretøj (kun admin)',
            params = {
                model = { name = 'model', help = 'Model navn på køretøjet' },
            },
        },
        dv = { help = 'Slet køretøj (kun admin)' },
        givemoney = {
            help = 'Giv en spiller penge (kun admin)',
            params = {
                id = { name = 'id', help = 'Spiller ID' },
                moneytype = { name = 'pengetype', help = 'Type penge (cash, bank, crypto)' },
                amount = { name = 'beløb', help = 'Mængde penge' },
            },
        },
        setmoney = {
            help = 'Indstil spillerens pengebeløb (kun administrator)',
            params = {
                id = { name = 'id', help = 'Spiller ID' },
                moneytype = { name = 'pengetype', help = 'Type penge (cash, bank, crypto)' },
                amount = { name = 'beløb', help = 'Mængde penge' },
            },
        },
        job = { help = 'Tjek Dit Job' },
        setjob = {
            help = 'Sæt en spillers job (kun admin)',
            params = {
                id = { name = 'id', help = 'Spiller ID' },
                job = { name = 'job', help = 'Job navn' },
                grade = { name = 'grade', help = 'Job grade' },
            },
        },
        gang = { help = 'Tjek din bande' },
        setgang = {
            help = 'Sæt en spiller til bande (kun admin)',
            params = {
                id = { name = 'id', help = 'Spiller ID' },
                gang = { name = 'bande', help = 'Bande navn' },
                grade = { name = 'grade', help = 'Bande grade' },
            },
        },
        ooc = { help = 'OOC Chat Besked' },
        me = {
            help = 'Vis lokal besked',
            params = {
                message = { name = 'besked', help = 'Besked at sende' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

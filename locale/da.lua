local Translations = {
    error = {
        not_online = 'Spiller er ikke online',
        wrong_format = 'Forkert format',
        missing_args = 'Ikke alle argumenter er blevet indtastet (x, y, z)',
        missing_args2 = 'Alle argumenter skal udfyldes!',
        no_access = 'Du har ikke adgang til denne kommando',
        company_too_poor = 'Din arbejdsgiver er fattig',
        item_not_exist = 'Ting findes ikke',
        too_heavy = 'Inventar er fyldt',
        location_not_exist = 'Lokation findes ikke',
        duplicate_license = 'Dublet Rockstar-licens fundet',
        no_valid_license  = 'Intet gyldig Rockstar-licens fundet',
        not_whitelisted = 'Du er ikke allowlistet på denne server',
        server_already_open = 'Serveren er allerede åben',
        server_already_closed = 'Serveren er allerede lukket',
        no_permission = 'Du har ikke tilladelser til dette..',
        no_waypoint = 'Ingen waypoint indstillet.',
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
        received_paycheck = 'Du har modtaget din lønseddel DKK%{value}',
        job_info = 'Job: %{value} | Grad: %{value2} | Duty: %{value3}',
        gang_info = 'Bande: %{value} | Grad: %{value2}',
        on_duty = 'Du er nu på vagt!',
        off_duty = 'Du har nu fri!',
        checking_ban = 'Hej %s. Vi tjekker, om du er bannet.',
        join_server = 'Velkommen %s til {Server Name}.',
        checking_whitelisted = 'Hej %s. Vi tjekker om du er allowlistet.',
        exploit_banned = 'Du er blevet bannet for snyd. Tjek vores Discord for mere information: %{discord}',
        exploit_dropped = 'Du er blevet kicked for udnyttelse',
    },
    command = {
        tp = {
            help = 'TP til spiller eller koordinater (Kun admin)',
            params = {
                x = { name = 'id/x', help = 'ID for spiller eller X position'},
                y = { name = 'y', help = 'Y position'},
                z = { name = 'z', help = 'Z position'},
            },
        },
        tpm = { help = 'TP til markør (Kun admin)' },
        togglepvp = { help = 'Slå PVP til og fra på serveren (Kun admin)' },
        addpermission = {
            help = 'Giv spillertilladelser (Kun Gud)',
            params = {
                id = { name = 'id', help = 'ID på spiller' },
                permission = { name = 'permission', help = 'Tilladelse niveau' },
            },
        },
        removepermission = {
            help = 'Fjern spillertilladelser (Kun Gud)',
            params = {
                id = { name = 'id', help = 'ID på spiller' },
                permission = { name = 'permission', help = 'Tilladelse niveau' },
            },
        },
        openserver = { help = 'Åbn serveren for alle (Kun admin)' },
        closeserver = {
            help = 'Luk serveren for personer uden tilladelser (Kun admin)',
            params = {
                reason = { name = 'reason', help = 'Begrundelse for lukning (valgfrit)' },
            },
        },
        car = {
            help = 'Spawn Køretøj (Kun admin)',
            params = {
                model = { name = 'model', help = 'Modelnavn på køretøjet' },
            },
        },
        dv = { help = 'Slet køretøj (Kun admin)' },
        givemoney = {
            help = 'Giv en spiller penge (Kun admin)',
            params = {
                id = { name = 'id', help = 'Spiller ID' },
                moneytype = { name = 'moneytype', help = 'Pengetype (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Pengebeløb' },
            },
        },
        setmoney = {
            help = 'Indstil spillerens pengebeløb (Kun admin)',
            params = {
                id = { name = 'id', help = 'Spiller ID' },
                moneytype = { name = 'moneytype', help = 'Pengetype (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Pengebeløb' },
            },
        },
        job = { help = 'Tjek dit job' },
        setjob = {
            help = 'Giv en spiller et job (Kun admin)',
            params = {
                id = { name = 'id', help = 'spiller ID' },
                job = { name = 'job', help = 'Job navn' },
                grade = { name = 'grade', help = 'Job Grad' },
            },
        },
        gang = { help = 'Tjek din bande' },
        setgang = {
            help = 'Giv en spiller bande rank (Kun admin)',
            params = {
                id = { name = 'id', help = 'Spiller ID' },
                gang = { name = 'gang', help = 'Bande navn' },
                grade = { name = 'grade', help = 'Bande grad' },
            },
        },
        ooc = { help = 'OOC Chat Besked' },
        me = {
            help = 'Vis lokal besked',
            params = {
                message = { name = 'message', help = 'Besked, der skal sendes' }
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

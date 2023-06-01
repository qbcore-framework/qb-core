local Translations = {
    error = {
        not_online = 'Spelaren är inte online',
        wrong_format = 'Felaktigt format',
        missing_args = 'Alla argument har inte angetts (x, y, z)',
        missing_args2 = 'Alla argument måste fyllas i!',
        no_access = 'Du har inte tillgång till detta kommando',
        company_too_poor = 'Din arbetsgivare är pank',
        item_not_exist = 'Objektet finns inte',
        too_heavy = 'Ditt inventory är fullt!',
        location_not_exist = 'Platsen finns inte',
        duplicate_license = 'Duplicerad Rockstar Licens Funnet',
        no_valid_license  = 'Ingen Giltig Rockstar Licens Hittades',
        not_whitelisted = 'Du är inte whitelistad på servern',
        server_already_open = 'Servern är redan öppen',
        server_already_closed = 'Servern är redan stängd',
        no_permission = 'Du har inte behörigheter för detta..',
        no_waypoint = 'Ingen waypoint satt.',
        tp_error = 'Fel vid teleportering.',
        connecting_database_error = 'Ett databasfel inträffade under anslutningen till servern.(Är SQL-servern på?)',
        connecting_database_timeout = 'Anslutning till databasen timed out.(Är SQL-servern på?)',
    },
    success = {
        server_opened = 'Servern har öppnats',
        server_closed = 'Servern har stängts',
        teleported_waypoint = 'Teleporterad till waypoint.',
    },
    info = {
        received_paycheck = 'Du fick din lönecheck på SEK%{value}',
        job_info = 'Jobb: %{value} | Grad: %{value2} | Tjänst: %{value3}',
        gang_info = 'Gäng: %{value} | Grad: %{value2}',
        on_duty = 'Du är nu i tjänst!',
        off_duty = 'Du har gått ur tjänst!',
        checking_ban = 'Hej %s. Validerar Användare.',
        join_server = 'Välkommen %s.',
        checking_whitelisted = 'Hej %s. Vi kontrollerar din whitelist.',
        exploit_banned = 'Du har blivit bannad för fusk. Kontrollera vår discord för mer information: %{discord}',
        exploit_dropped = 'Du har blivit sparkad för Exploitation',
    },
    command = {
        tp = {
            help = 'TP till spelare eller koords (Admin Only)',
            params = {
                x = { name = 'id/x', help = 'ID för spelare eller X-position'},
                y = { name = 'y', help = 'Y position'},
                z = { name = 'z', help = 'Z position'},
            },
        },
        tpm = { help = 'TP till markör (Admin Only)' },
        togglepvp = { help = 'Växla PvP på servern (Admin Only)' },
        addpermission = {
            help = 'Ge spelarbehörigheter (God Only)',
            params = {
                id = { name = 'id', help = 'ID på spelare' },
                permission = { name = 'permission', help = 'Behörighetsnivå' },
            },
        },
        removepermission = {
            help = 'Ta bort spelarbehörigheter (God Only)',
            params = {
                id = { name = 'id', help = 'ID på spelare' },
                permission = { name = 'permission', help = 'Behörighetsnivå' },
            },
        },
        openserver = { help = 'Öppna servern för alla (Admin Only)' },
        closeserver = {
            help = 'Stäng servern för personer utan behörigheter (Admin Only)',
            params = {
                reason = { name = 'reason', help = 'Anledning till stängning (frivillig)' },
            },
        },
        car = {
            help = 'Spawna Fordon (Admin Only)',
            params = {
                model = { name = 'model', help = 'Fordonets modellnamn' },
            },
        },
        dv = { help = 'Radera fordon (Admin Only)' },
        givemoney = {
            help = 'Ge en spelare pengar (Admin Only)',
            params = {
                id = { name = 'id', help = 'Spelar-ID' },
                moneytype = { name = 'moneytype', help = 'Typ av pengar (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Belopp' },
            },
        },
        setmoney = {
            help = 'Sätt spelar pengar (Admin Only)',
            params = {
                id = { name = 'id', help = 'Spelar-ID' },
                moneytype = { name = 'moneytype', help = 'Typ av pengar (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Belopp' },
            },
        },
        job = { help = 'Kolla ditt jobb' },
        setjob = {
            help = 'Sätt Spelar-Jobb (Admin Only)',
            params = {
                id = { name = 'id', help = 'Spelar-ID' },
                job = { name = 'job', help = 'Jobbnamn' },
                grade = { name = 'grade', help = 'Jobb-Grad' },
            },
        },
        gang = { help = 'Kolla ditt gäng' },
        setgang = {
            help = 'Sätt spelar-gäng (Admin Only)',
            params = {
                id = { name = 'id', help = 'Spelar-ID' },
                gang = { name = 'gang', help = 'Gängnamn' },
                grade = { name = 'grade', help = 'Gäng-grad' },
            },
        },
        ooc = { help = 'OOC-chattmeddelande' },
        me = {
            help = 'Visa lokalt meddelande',
            params = {
                message = { name = 'message', help = 'Meddelande' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

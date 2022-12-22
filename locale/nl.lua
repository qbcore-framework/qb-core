local Translations = {
    error = {
        not_online = 'Speler is niet online',
        wrong_format = 'Onjuiste opmaak',
        missing_args = 'Niet elk argument is ingevuld (x, y, z)',
        missing_args2 = 'Alle argumenten moeten worden ingevuld!',
        no_access = 'Geen toegang tot dit commando',
        company_too_poor = 'Je werkgever is arm',
        item_not_exist = 'Item bestaat niet',
        too_heavy = 'Inventaris is te vol',
        duplicate_license = 'Dubbele Rockstar-licentie gevonden',
        no_valid_license  = 'Geen geldige Rockstar-licentie gevonden',
        not_whitelisted = 'Je staat niet op de whitelist voor deze server'
        server_already_open = 'Server is al open',
        server_already_closed = 'Server is gesloten',
        no_permission = 'Je hebt geen rechten om dit te doen..',
        no_waypoint = 'Geen Route Ingesteld.',
        tp_error = 'Fout Bij Teleporteren.',
        connecting_database_error = 'Er is een databasefout opgetreden tijdens het verbinden met de server. (Staat de SQL-server aan?)',
        connecting_database_timeout = 'Verbinding met database timed out. (Staat de SQL server aan?)',
    },
    success = {
        server_opened = 'De server is geopend',
        server_closed = 'De server is gesloten',
        teleported_waypoint = 'Naar Route Geteleporteerd.',
    },
    info = {
        received_paycheck = 'Je hebt je salaris van $%{value} ontvangen',
        job_info = 'Baan: %{value} | Rang: %{value2} | In dienst: %{value3}',
        gang_info = 'Gang: %{value} | Rang: %{value2}',
        on_duty = 'Je bent nu in dienst!',
        off_duty = 'Je bent nu uit dienst!',
        checking_ban = 'Hallo %s. We controleren of je verbannen bent.',
        join_server = 'Welkom %s bij {Server Name}.',
        checking_whitelisted = 'Hallo %s. We controleren of je op de whitelist staat.'
        exploit_banned = 'Je bent verbannen voor valsspelen. Check onze Discord voor meer informatie: %{discord}',
        exploit_dropped = 'Je bent Ge-Kicked Voor Exploit gebruik',
    },
    command = {
        tp = {
            help = 'TP naar speler of coördinaten (Alleen Admin)',
            params = {
                x = { name = 'id/x', help = 'ID van spelenr of X positie'},
                y = { name = 'y', help = 'Y positie'},
                z = { name = 'z', help = 'Z positie'},
            },
        },
        tpm = { help = 'TP Naar Route (Alleen Admin)' },
        togglepvp = { help = 'Schakel PVP op de server (Alleen Admin)' },
        addpermission = {
            help = 'Speler Rechten Geven (Alleen God)',
            params = {
                id = { name = 'id', help = 'ID van speler' },
                permission = { name = 'permission', help = 'Machtigingsniveau' },
            },
        },
        removepermission = {
            help = 'Verwijder Speler Rechten (Alleen God)',
            params = {
                id = { name = 'id', help = 'ID van speler' },
                permission = { name = 'permission', help = 'Machtigingsniveau' },
            },
        },
        openserver = { help = 'Open de server voor iedereen (Alleen Admin)' },
        closeserver = {
            help = 'Sluit de server voor mensen zonder rechten (Alleen Admin)',
            params = {
                reason = { name = 'reason', help = 'Reden voor sluiten (optioneel)' },
            },
        },
        car = {
            help = 'Auto Spawnen (Alleen Admin)',
            params = {
                model = { name = 'model', help = 'Modelnaam van het voertuig' },
            },
        },
        dv = { help = 'Verwijder Voertuig (Alleen Admin)' },
        givemoney = {
            help = 'Geef een speler geld (Alleen Admin)',
            params = {
                id = { name = 'id', help = 'Speler ID' },
                moneytype = { name = 'moneytype', help = 'Type van geld (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Geldbedrag' },
            },
        },
        setmoney = {
            help = 'Spelers geldbedrag instellen (Alleen Admin)',
            params = {
                id = { name = 'id', help = 'Speler ID' },
                moneytype = { name = 'moneytype', help = 'Type van geld (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Geldbedrag' },
            },
        },
        job = { help = 'Bekijk je baan' },
        setjob = {
            help = 'Stel een spelersbaan in (Alleen Admin)',
            params = {
                id = { name = 'id', help = 'Speler ID' },
                job = { name = 'job', help = 'Baan naam' },
                grade = { name = 'grade', help = 'Baan rang' },
            },
        },
        gang = { help = 'Controleer je bende' },
        setgang = {
            help = 'Stel Bende van Speler In (Alleen Admin)',
            params = {
                id = { name = 'id', help = 'Speler ID' },
                gang = { name = 'gang', help = 'Bende Naam' },
                grade = { name = 'grade', help = 'Bende rang' },
            },
        },
        ooc = { help = 'OOC Chat Bericht' },
        me = {
            help = 'Toon lokaal bericht',
            params = {
                message = { name = 'message', help = 'Te verzenden bericht' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

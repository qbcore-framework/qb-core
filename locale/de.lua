local Translations = {
    error = {
        not_online = 'Der Spieler ist nicht online',
        wrong_format = 'Falsches Format',
        missing_args = 'Nicht alle Argumente wurden ausgefüllt (x, y, z)',
        missing_args2 = 'Alle Argumente müssen ausgefüllt sein!',
        no_access = 'Kein Zugriff auf diesen Befehl',
        company_too_poor = 'Dein Arbeitgeber hat kein Geld mehr',
        item_not_exist = 'Das Item existiert nicht',
        too_heavy = 'Inventar zu voll',
        location_not_exist = 'Der Ort existiert nicht',
        duplicate_license = 'Doppelte Rockstar-Lizenz gefunden',
        no_valid_license  = 'Keine verifizierte Rockstar-Lizenz gefunden',
        not_whitelisted = 'Du bist nicht gewhitelisted',
        server_already_open = 'Der Server ist schon geöffnet',
        server_already_closed = 'Der Server ist schon geschlossen',
        no_permission = 'Du hast keine Rechte dafür..',
        no_waypoint = 'Kein Wegpunkt gesetzt.',
        tp_error = 'Error beim teleportieren.',
    },
    success = {
        server_opened = 'Der Server wurde geöffnet',
        server_closed = 'Der Server wurde geschlossen',
        teleported_waypoint = 'Zum Wegpunkt teleportiert.',
    },
    info = {
        received_paycheck = 'Du hast dein Gehalt in Höhe von $%{value} erhalten',
        job_info = 'Job: %{value} | Dienstgrad: %{value2} | im Dienst: %{value3}',
        gang_info = 'Gang: %{value} | Rang: %{value2}',
        on_duty = 'Du bist nun im Dienst!',
        off_duty = 'Du bist nun nicht mehr im Dienst!',
        join_server = 'Willkommen %s zu {Server Name}.',
        checking_ban = 'Checking banned status... 🔨',
        checking_whitelisted = 'Checking whitelist status... 👑',
        checking_license_credentials = 'Checking license credentials... 📖',
        checking_license_duplicate = 'Checking for duplicate license... ⛓️',
        exploit_banned = 'Du wurdest fürs Cheaten gebannt. Meld dich auf dem Discord: %{discord}',
        exploit_dropped = 'Du wurdest gekickt für das Ausnutzen von Fehlern',
    },
    command = {
        tp = {
            help = 'TP zu Spieler oder Coords (Nur Admins)',
            params = {
                x = { name = 'id/x', help = 'ID vom Spieler oder X position'},
                y = { name = 'y', help = 'Y position'},
                z = { name = 'z', help = 'Z position'},
            },
        },
        tpm = { help = 'TP zum Marker (Nur Admins)' },
        togglepvp = { help = 'Schalte PVP ein oder aus (Nur Admins)' },
        addpermission = {
            help = 'Gebe einem Spieler Rechte (God Only)',
            params = {
                id = { name = 'id', help = 'ID des Spielers' },
                permission = { name = 'permission', help = 'Zugriffsrechte' },
            },
        },
        removepermission = {
            help = 'Nimm jemand die Rechte (God Only)',
            params = {
                id = { name = 'id', help = 'ID des Spielers' },
                permission = { name = 'permission', help = 'Zugriffsrechte' },
            },
        },
        openserver = { help = 'Öffne den Server für jeden (Nur Admins)' },
        closeserver = {
            help = 'Schließe den Server für Leute ohne Rechte (Nur Admins)',
            params = {
                reason = { name = 'reason', help = 'Grund fürs schließen (optional)' },
            },
        },
        car = {
            help = 'Spawne ein Fahrzeug (Nur Admins)',
            params = {
                model = { name = 'model', help = 'Modell Name' },
            },
        },
        dv = { help = 'Fahrzeug entfernen (Nur Admins)' },
        givemoney = {
            help = 'Gib jemandem Geld (Nur Admins)',
            params = {
                id = { name = 'id', help = 'Spieler ID' },
                moneytype = { name = 'moneytype', help = 'Geldtyp (Bargeld, Bank, Crypto)' },
                amount = { name = 'amount', help = 'Geldmenge' },
            },
        },
        setmoney = {
            help = 'Setze die Geldmenge für einen Spieler (Nur Admins)',
            params = {
                id = { name = 'id', help = 'Spieler ID' },
                moneytype = { name = 'moneytype', help = 'Geldtyp (Bargeld, Bank, Crypto)' },
                amount = { name = 'amount', help = 'Geldmenge' },
            },
        },
        job = { help = 'Check deinen Job' },
        setjob = {
            help = 'Setze den Job eines Spielers (Nur Admins)',
            params = {
                id = { name = 'id', help = 'Spieler ID' },
                job = { name = 'job', help = 'Job Name' },
                grade = { name = 'grade', help = 'Dienstgrad' },
            },
        },
        gang = { help = 'Check deine Gang' },
        setgang = {
            help = 'Setze die Gang eines Spielers (Nur Admins)',
            params = {
                id = { name = 'id', help = 'Spieler ID' },
                gang = { name = 'gang', help = 'Gang Name' },
                grade = { name = 'grade', help = 'Gang Rang' },
            },
        },
        ooc = { help = 'OOC Chat Nachricht' },
        me = {
            help = 'Locale Chat Nachricht',
            params = {
                message = { name = 'message', help = 'Nachricht zu senden' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
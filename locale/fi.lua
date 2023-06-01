local Translations = {
    error = {
        not_online = 'Pelaaja ei ole paikalla',
        wrong_format = 'Väärä formaatti',
        missing_args = 'Kaikkia argumentteja ei ole syötetty (x, y, z)',
        missing_args2 = 'Kaikki argumentit on täytettävä!',
        no_access = 'Ei pääsyä tähän komentoon',
        company_too_poor = 'Työnantajasi on köyhä',
        item_not_exist = 'Kohdetta ei ole olemassa',
        too_heavy = 'Taskusi ovat täynnä',
        location_not_exist = 'Sijaintia ei ole olemassa',
        duplicate_license = 'Rockstar-lisenssin kaksoiskappale löydetty',
        no_valid_license  = 'Voimassa olevaa Rockstar-lisenssiä ei löytynyt',
        not_whitelisted = 'Sinua ei ole lisätty tämän palvelimen allowlistille',
        server_already_open = 'Serveri on jo auki',
        server_already_closed = 'Serveri on jo suljettu',
        no_permission = 'Sinulla ei ole oikeuksia tämmöseen..',
        no_waypoint = 'Et ole asettanut waypointtia.',
        tp_error = 'Virhe teleportatessa.',
        connecting_database_error = 'Tietokantavirhe muodostettaessa yhteyttä palvelimeen. (Onko SQL-palvelin päällä?)',
        connecting_database_timeout = 'Yhteys tietokantaan aikakatkaistiin. (Onko SQL-palvelin päällä?)',
    },
    success = {
        server_opened = 'Palvelin on avattu',
        server_closed = 'Palvelin on suljettu',
        teleported_waypoint = 'Teleporttaa Waypointille',
    },
    info = {
        received_paycheck = 'Olet saanut palkkasi $%{value}',
        job_info = 'Työ: %{value} | Arvo: %{value2} | Vuorossa: %{value3}',
        gang_info = 'Jengi: %{value} | Arvo: %{value2}',
        on_duty = 'Olet nyt vuorossa',
        off_duty = 'Olet nyt poisvuorosta!',
        checking_ban = 'Tervehdys %s. Tarkistetaan oletko saanut porttikieltoa.',
        join_server = 'Tervetuloa %s - {Server Name}.',
        checking_whitelisted = 'Terve %s. Tarkistamme etusi.',
        exploit_banned = 'Sinut on bännatty cheattaamisesta. Katso lisätietoja Discordistamme: %{discord}',
        exploit_dropped = 'Sinua on potkittu hyväksikäytön vuoksi',
    },
    command = {
        tp = {
            help = 'TP pelaajalle tai koordinaateille (Vain Admineille)',
            params = {
                x = { name = 'id/x', help = 'Pelaajan ID tai X-paikka'},
                y = { name = 'y', help = 'Y position'},
                z = { name = 'z', help = 'Z position'},
            },
        },
        tpm = { help = 'TP Markerille (Vain Admineille)' },
        togglepvp = { help = 'Vaihda PVP palvelimelle (Vain Admineille)' },
        addpermission = {
            help = 'Anna pelaajalle admin oikeudet (God Only)',
            params = {
                id = { name = 'id', help = 'Pelaajan ID' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        removepermission = {
            help = 'Poista pelaajatlta admin oikeudet (God Only)',
            params = {
                id = { name = 'id', help = 'Pelaajan ID' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        openserver = { help = 'Avaa palvelin kaikille (Vain Admineille)' },
        closeserver = {
            help = 'Sulje palvelin ihmisiltä, ​​joilla ei ole oikeuksia (Vain Admineille)',
            params = {
                reason = { name = 'reason', help = 'Sulkemisen syy (valinnainen)' },
            },
        },
        car = {
            help = 'Spawnaa ajoneuvo (Vain Admineille)',
            params = {
                model = { name = 'model', help = 'Ajoneuvon nimi' },
            },
        },
        dv = { help = 'Poista ajoneuvo (Vain Admineille)' },
        givemoney = {
            help = 'Anna Pelaajalle rahaa (Vain Admineille)',
            params = {
                id = { name = 'id', help = 'Pelaajan ID' },
                moneytype = { name = 'moneytype', help = 'Rahan tyyppi (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Rahan määrä' },
            },
        },
        setmoney = {
            help = 'Aseta pelaajien rahasumma (Vain Admineille)',
            params = {
                id = { name = 'id', help = 'Pelaajan ID' },
                moneytype = { name = 'moneytype', help = 'Rahan tyyppi (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Rahan määrä' },
            },
        },
        job = { help = 'katso työsi' },
        setjob = {
            help = 'Aseta pelaajalle työ (Vain Admineille)',
            params = {
                id = { name = 'id', help = 'Pelaajan ID' },
                job = { name = 'job', help = 'Työn nimi' },
                grade = { name = 'grade', help = 'Arvo' },
            },
        },
        gang = { help = 'Katso jengisi' },
        setgang = {
            help = 'Aseta pelaajalle jengi (Vain Admineille)',
            params = {
                id = { name = 'id', help = 'Pelaajan ID' },
                gang = { name = 'gang', help = 'Jengin Nimi' },
                grade = { name = 'grade', help = 'Arvo' },
            },
        },
        ooc = { help = 'OOC Viesti lähipelaajille' },
        me = {
            help = 'Näytä paikallinen viesti',
            params = {
                message = { name = 'message', help = 'Mitä haluat kertoa?' }
            },
        },
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

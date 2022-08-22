local Translations = {
    error = {
        not_online = 'ekki á netinu',
        wrong_format = 'rangt snið',
        missing_args = 'Ekki er búið að færa inn öll rök (x, y, z)',
        missing_args2 = 'Öll rök verður að fylla út!',
        no_access = 'Enginn aðgangur að þessari skipun',
        company_too_poor = 'Vinnuveitandi þinn er blankur',
        item_not_exist = 'Varan er ekki til',
        too_heavy = 'Birgðir of fullar',
        location_not_exist = 'Staðsetning er ekki til',
        duplicate_license = 'Afrit Rockstar leyfi fannst',
        no_valid_license  = 'Ekkert gilt Rockstar leyfi fannst',
        not_whitelisted = 'Þú  ert ekki á hvítlista fyrir þennan netþjón',
        server_already_open = 'Miðlarinn er þegar opinn',
        server_already_closed = 'Miðlarinn er þegar lokaður',
        no_permission = 'Þú hefur ekki heimildir fyrir þessu..',
        no_waypoint = 'Engin leiðarpunktur settur.',
        tp_error = 'Villa við fjarflutning.',
    },
    success = {
        server_opened = 'Miðlarinn hefur verið opnaður',
        server_closed = 'Miðlarinn hefur verið lokaður',
        teleported_waypoint = 'Teleported til Waypoint.',
    },
    info = {
        received_paycheck = 'Þú fékkst launaseðilinn þinn af $%{value}',
        job_info = 'Starf: %{value} | Einkunn: %{value2} | Skylda: %{value3}',
        gang_info = 'Gang: %{value} | Einkunn: %{value2}',
        on_duty = 'Þú ert nú á vakt!',
        off_duty = 'Þú ert nú á vakt!',
        checking_ban = 'Halló %s. Við erum að athuga hvort þú sért bannaður.',
        join_server = 'Velkominn %s til {Nafn netþjóns}.',
        checking_whitelisted = 'Halló %s. Við erum að athuga vasapeningana þína.',
        exploit_banned = 'Þú hefur verið bannaður fyrir svindl. Athugaðu Discord okkar til að fá frekari upplýsingar: %{discord}',
        exploit_dropped = 'Þér hefur verið sparkað fyrir arðrán',
    },
    command = {
        tp = {
            help = 'TP Til leikmanns eða coords (Aðeins stjórnandi)',
            params = {
                x = { name = 'id/x', help = 'ID af leikmanni eða X staða'},
                y = { name = 'y', help = 'Y position'},
                z = { name = 'z', help = 'Z position'},
            },
        },
        tpm = { help = 'TP To Til Marker (Aðeins stjórnandi)' },
        togglepvp = { help = 'Toggle PVP on the server (Aðeins stjórnandi)' },
        addpermission = {
            help = 'Give Player Permissions (God Only)',
            params = {
                id = { name = 'id', help = 'ID of player' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        removepermission = {
            help = 'Remove Player Permissions (God Only)',
            params = {
                id = { name = 'id', help = 'ID of player' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        openserver = { help = 'Open the server for everyone (Aðeins stjórnandi)' },
        closeserver = {
            help = 'Close the server for people without permissions (Aðeins stjórnandi)',
            params = {
                reason = { name = 'reason', help = 'Reason for closing (optional)' },
            },
        },
        car = {
            help = 'Spawn Vehicle (Aðeins stjórnandi)',
            params = {
                model = { name = 'model', help = 'Model name of the vehicle' },
            },
        },
        dv = { help = 'Delete Vehicle (Aðeins stjórnandi)' },
        givemoney = {
            help = 'Gefðu spilara peninga (Aðeins stjórnandi)',
            params = {
                id = { name = 'id', help = 'Leikmaður ID' },
                moneytype = { name = 'moneytype', help = 'Tegund peninga (reiðufé, banki, dulritun)' },
                amount = { name = 'amount', help = 'Magn peninga' },
            },
        },
        setmoney = {
            help = 'Stilltu peningaupphæð leikmanna (Aðeins stjórnandi)',
            params = {
                id = { name = 'id', help = 'Leikmaður ID' },
                moneytype = { name = 'moneytype', help = 'Tegund peninga (reiðufé, banki, dulritun)' },
                amount = { name = 'amount', help = 'Magn peninga' },
            },
        },
        job = { help = 'Athugaðu starf þitt' },
        setjob = {
            help = 'Settu leikmannastarf (Aðeins stjórnandi)',
            params = {
                id = { name = 'id', help = 'Leikmaður ID' },
                job = { name = 'job', help = 'Nafn starfs' },
                grade = { name = 'grade', help = 'Starfseinkunn' },
            },
        },
        gang = { help = 'Athugaðu þinn Gang' },
        setgang = {
            help = 'Stilltu leikmann Gang (Aðeins stjórnandi)',
            params = {
                id = { name = 'id', help = 'Leikmaður ID' },
                gang = { name = 'gang', help = ' klíku nafn' },
                grade = { name = 'grade', help = ' klíkustig' },
            },
        },
        ooc = { help = 'OOC spjallskilaboð' },
        me = {
            help = 'Sýna staðbundin skilaboð',
            params = {
                message = { name = 'message', help = 'Skilaboð til að senda' }
            },
        },
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

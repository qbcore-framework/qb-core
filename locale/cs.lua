local Translations = {
    error = {
        not_online = 'Hráč není online',
        wrong_format = 'Nesprávný formát',
        missing_args = 'Né všechny argumenty byly vyplněny (x, y, z)',
        missing_args2 = 'Všechny argumenty musí být vyplněný!',
        no_access = 'Nemáte přístup k tomuto příkazu',
        company_too_poor = 'Váš zaměstnavatel nemá dostatek peněz, aby vás vyplatil',
        item_not_exist = 'Předmět neexistuje',
        too_heavy = 'Inventář je plný',
        duplicate_license = 'Stejná Rockstar licence je již na serveru',
        no_valid_license  = 'Nebyla nalezena žádná platná Rockstar licence',
        not_whitelisted = 'Nejste na whitelistu'
    },
    success = {
        server_opened = 'Server byl otevřen',
        server_closed = 'Server byl uzavřen',
        teleported_waypoint = 'Teleportováno na Waypoint.',
    },
    info = {
        received_paycheck = 'Obdrželi jste výplatu v hodnotě $%{value}',
        job_info = 'Práce: %{value} | Pozice: %{value2} | Ve službě: %{value3}',
        gang_info = 'Gang: %{value} | Pozice: %{value2}',
        on_duty = 'Vešli jste do služby',
        off_duty = 'Odešli jste ze služby!',
        checking_ban = 'Ahoj %s. Kontrolujeme zda nejste zabanováni.',
        join_server = 'Vítejte %s na {Server Name}.',
        checking_whitelisted = 'Ahoj %s. Kontrolujeme zda máte přístup.'
    },
    command = {
        tp = {
            help = 'Teleport k hráči nebo na souřadnice (Pouze Admin)',
            params = {
                x = { name = 'id/x', help = 'ID hráče nebo X pozice'},
                y = { name = 'y', help = 'Y pozice'},
                z = { name = 'z', help = 'Z pozice'},
            },
        },
        tpm = { help = 'TP Na Marker (pouze Admin)' },
        togglepvp = { help = 'Přepnutí PVP na serveru (Pouze Admin)' },
        addpermission = {
            help = 'Udělení hráči oprávnění (God Pouze)',
            params = {
                id = { name = 'id', help = 'ID hráče' },
                permission = { name = 'permission', help = 'Úroveň oprávnění' },
            },
        },
        removepermission = {
            help = 'Odeber hráči oprávnění (God Pouze)',
            params = {
                id = { name = 'id', help = 'ID hráče' },
                permission = { name = 'permission', help = 'Úroveň oprávnění' },
            },
        },
        openserver = { help = 'Otevři server pro všechny (Pouze Admin)' },
        closeserver = {
            help = 'Uzavři server pro všechny bez práv (Pouze Admin)',
            params = {
                reason = { name = 'reason', help = 'Důdov pro uzavření (optimální)' },
            },
        },
        car = {
            help = 'Spawn Vozidla (Pouze Admin)',
            params = {
                model = { name = 'model', help = 'Jméno modelu vozidla' },
            },
        },
        dv = { help = 'Odstraň vozidlo (Pouze Admin)' },
        givemoney = {
            help = 'Dej hráči peníze (Pouze Admin)',
            params = {
                id = { name = 'id', help = 'ID hráče' },
                moneytype = { name = 'moneytype', help = 'Typ (hotovost, banka, krypto)' },
                amount = { name = 'amount', help = 'Počet peněz' },
            },
        },
        setmoney = {
            help = 'Nastav hráči peníze (Pouze Admin)',
            params = {
                id = { name = 'id', help = 'ID hráče' },
                moneytype = { name = 'moneytype', help = 'Typ (hotovost, banka, krypto)' },
                amount = { name = 'amount', help = 'Počet peněz' },
            },
        },
        job = { help = 'Zkontroluj si práci' },
        setjob = {
            help = 'Nastav hráči práci (Pouze Admin)',
            params = {
                id = { name = 'id', help = 'ID hráče' },
                job = { name = 'job', help = 'Jméno práce' },
                grade = { name = 'grade', help = 'Jméno hodnosti' },
            },
        },
        gang = { help = 'Zkontroluj si gang' },
        setgang = {
            help = 'Nastav hráči gang (Pouze Admin)',
            params = {
                id = { name = 'id', help = 'ID hráče' },
                gang = { name = 'gang', help = 'Jméno gangu' },
                grade = { name = 'grade', help = 'Pozice v gangu' },
            },
        },
        ooc = { help = 'OOC Chat' },
        me = {
            help = 'Ukaž zprávu',
            params = {
                message = { name = 'message', help = 'Zpráva k odeslání' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

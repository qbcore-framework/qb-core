local Translations = {
    error = {
        not_online = 'Mängija pole serveris',
        wrong_format = 'Vale vorming',
        missing_args = 'Kõiki argumente pole sisestatud (x, y, z)',
        missing_args2 = 'Kõik argumendid tuleb täita!',
        no_access = 'Sellele käsule pole juurdepääsu',
        company_too_poor = 'Teie tööandja on võlgades',
        item_not_exist = 'Asi ei eksisteeri',
        too_heavy = 'Inventuur on liiga täis',
        location_not_exist = 'Asukoht ei eksisteeri',
        duplicate_license = 'Leiti Rockstari litsentsi duplikaat',
        no_valid_license  = 'Kehtivat Rockstari litsentsi ei leitud',
        not_whitelisted = 'Te ei ole selle serveri jaoks Allowlisted',
        server_already_open = 'Server on juba avatud',
        server_already_closed = 'Server on juba suletud',
        no_permission = 'Teil pole selleks õigusi..',
        no_waypoint = 'Ühtegi punkti ei ole märgitud.',
        tp_error = 'Teleportimise viga.',
    },
    success = {
        server_opened = 'Server on avatud',
        server_closed = 'Server on suletud',
        teleported_waypoint = 'Teleporteerusid punktile.',
    },
    info = {
        received_paycheck = 'Saite oma palga $%{value}',
        job_info = 'Töö: %{value} | Auaste: %{value2} | Tööpostil: %{value3}',
        gang_info = 'Gang: %{value} | Auaste: %{value2}',
        on_duty = 'Sa oled tööle kirjutatud!',
        off_duty = 'Sa kirjutasid ennast töölt vabaks!',
        checking_ban = 'Tere %s. Me kontrollime, kas olete keelustatud.',
        join_server = 'Tere tulemast %s serverisse {Server Name}.',
        checking_whitelisted = 'Tere %s. Kontrollime teie Allowlisti staatust.',
        exploit_banned = 'Olete saanud petmise eest mängukeelu. Lisateabe saamiseks vaadake meie Discordi: %{discord}',
        exploit_dropped = 'Sind visati serverist välja petmise tõttu.',
    },
    command = {
        tp = {
            help = 'TP mängijale või koordinaatidele (ainult administraator)',
            params = {
                x = { name = 'id/x', help = 'ID mängija või X positsioon'},
                y = { name = 'y', help = 'Y positsioon'},
                z = { name = 'z', help = 'Z positsioon'},
            },
        },
        tpm = { help = 'TP Markerile (ainult administraator)' },
        togglepvp = { help = 'PVP serveris sisse- ja väljalülitamine (ainult administraator)' },
        addpermission = {
            help = 'Andke mängijale õigused (ainult jumal)',
            params = {
                id = { name = 'id', help = 'mängija ID' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        removepermission = {
            help = 'Eemaldage mängija õigused (ainult jumal)',
            params = {
                id = { name = 'id', help = 'mängija ID' },
                permission = { name = 'õigused', help = 'Õiguse tase' },
            },
        },
        openserver = { help = 'Ava server kõigile (ainult administraator)' },
        closeserver = {
            help = 'Sulgege server ilma õigusteta inimeste jaoks (ainult administraator)',
            params = {
                reason = { name = 'põhjus', help = 'Sulgemise põhjus (valikuline)' },
            },
        },
        car = {
            help = 'Sõiduki loomine (ainult administraator)',
            params = {
                model = { name = 'mudel', help = 'Sõiduki mudeli nimi' },
            },
        },
        dv = { help = 'Sõiduki kustutamine (ainult administraator)' },
        givemoney = {
            help = 'Mängija rahasumma määramine (ainult administraator)',
            params = {
                id = { name = 'id', help = 'Mängija ID' },
                moneytype = { name = 'rahatüüp', help = 'Raha liik (sularaha, pank, krüpto)' },
                amount = { name = 'kogus', help = 'Rahasumma' },
            },
        },
        setmoney = {
            help = 'Mängija rahasumma määramine (ainult administraator)',
            params = {
                id = { name = 'id', help = 'Mängija ID' },
                moneytype = { name = 'rahatüüp', help = 'Raha liik (sularaha, pank, krüpto)' },
                amount = { name = 'kogus', help = 'Rahasumma' },
            },
        },
        job = { help = 'Kontrollige oma töödkohta' },
        setjob = {
            help = 'Mängijale töökoha määramine (ainult administraator)',
            params = {
                id = { name = 'id', help = 'Mängija ID' },
                job = { name = 'töö', help = 'Töökoha nimi' },
                grade = { name = 'tase', help = 'Tüükoha tase' },
            },
        },
        gang = { help = 'Kontrollige oma grupeeringut' },
        setgang = {
            help = 'Määra mängija grupeeringu (ainult administraator)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                gang = { name = 'tase', help = 'Grupeeringu nimi' },
                grade = { name = 'tase', help = 'Grupeeringu tase' },
            },
        },
        ooc = { help = 'OOC vestlussõnum' },
        me = {
            help = 'Kuva kohalikud sõnumid',
            params = {
                message = { name = 'sõnum', help = 'Sõnum saatmiseks' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

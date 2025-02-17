local Translations = {
    error = {
        not_online                  = 'Oyuncu çevrimdışı',
        wrong_format                = 'Hatalı format',
        missing_args                = 'Tüm argümanlar girilmedi (x, y, z)',
        missing_args2               = 'Tüm argümanlar doldurulmalıdır!',
        no_access                   = 'Bu komut için erişiminiz yok',
        company_too_poor            = 'İşvereniniz iflas etti',
        item_not_exist              = 'Eşya mevcut değil',
        too_heavy                   = 'Envanter çok dolu',
        location_not_exist          = 'Konum mevcut değil',
        duplicate_license           = '[QBCORE] - Aynı Rockstar Lisansı Bulundu',
        no_valid_license            = '[QBCORE] - Geçerli Rockstar Lisansı Bulunamadı',
        not_whitelisted             = '[QBCORE] - Bu sunucu için beyaz listedesiniz',
        server_already_open         = 'Sunucu zaten açık',
        server_already_closed       = 'Sunucu zaten kapalı',
        no_permission               = 'Bu işlem için yetkiniz yok...',
        no_waypoint                 = 'Bir işaret noktası ayarlanmamış.',
        tp_error                    = 'Taşınırken hata oluştu.',
        ban_table_not_found         = '[QBCORE] - Veritabanında yasaklılar tablosu bulunamadı. Lütfen SQL dosyasının doğru şekilde yüklendiğinden emin olun.',
        connecting_database_error   = '[QBCORE] - Veritabanına bağlanırken hata oluştu. SQL sunucusunun çalıştığından ve server.cfg dosyasındaki bilgilerin doğru olduğundan emin olun.',
        connecting_database_timeout = '[QBCORE] - Veritabanı bağlantısı zaman aşımına uğradı. SQL sunucusunun çalıştığından ve server.cfg dosyasındaki bilgilerin doğru olduğundan emin olun.',
    },
    success = {
        server_opened = 'Sunucu açıldı',
        server_closed = 'Sunucu kapandı',
        teleported_waypoint = 'İşaret noktasına taşındınız.',
    },
    info = {
        received_paycheck = 'Maaşınızı $%{value} aldınız',
        job_info = 'İş: %{value} | Seviye: %{value2} | Görevde: %{value3}',
        gang_info = 'Çete: %{value} | Seviye: %{value2}',
        on_duty = 'Artık görevdeyiniz!',
        off_duty = 'Artık görev dışında oldunuz!',
        checking_ban = 'Merhaba %s. Yasaklı olup olmadığınızı kontrol ediyoruz.',
        join_server = 'Hoşgeldiniz %s, {Sunucu Adı}\'na.',
        checking_whitelisted = 'Merhaba %s. İzin durumunuzu kontrol ediyoruz.',
        exploit_banned = 'Hile yaptığınız için yasaklandınız. Daha fazla bilgi için Discord\'umuza göz atın: %{discord}',
        exploit_dropped = 'Hile yapmaktan dolayı sunucudan atıldınız',
    },
    command = {
        tp = {
            help = 'Oyuncuya veya Koordinatlara TP (Sadece Admin)',
            params = {
                x = { name = 'id/x', help = 'Oyuncu ID\'si veya X konumu' },
                y = { name = 'y', help = 'Y konumu' },
                z = { name = 'z', help = 'Z konumu' },
            },
        },
        tpm = { help = 'İşaret noktasına TP (Sadece Admin)' },
        togglepvp = { help = 'Sunucuda PVP modunu aç/kapat (Sadece Admin)' },
        addpermission = {
            help = 'Oyuncuya Yetki Ver (Tanrı Yetkisi)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                permission = { name = 'permission', help = 'Yetki seviyesi' },
            },
        },
        removepermission = {
            help = 'Oyuncudan Yetki Al (Tanrı Yetkisi)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                permission = { name = 'permission', help = 'Yetki seviyesi' },
            },
        },
        openserver = { help = 'Sunucuyu herkes için aç (Sadece Admin)' },
        closeserver = {
            help = 'Sunucuyu yetkisi olmayanlar için kapat (Sadece Admin)',
            params = {
                reason = { name = 'reason', help = 'Kapanma nedeni (isteğe bağlı)' },
            },
        },
        car = {
            help = 'Araç Spawn Et (Sadece Admin)',
            params = {
                model = { name = 'model', help = 'Araç model adı' },
            },
        },
        dv = { help = 'Aracı Sil (Sadece Admin)' },
        dvall = { help = 'Tüm Araçları Sil (Sadece Admin)' },
        dvp = { help = 'Tüm Pedleri Sil (Sadece Admin)' },
        dvo = { help = 'Tüm Objeleri Sil (Sadece Admin)' },
        givemoney = {
            help = 'Bir Oyuncuya Para Ver (Sadece Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                moneytype = { name = 'moneytype', help = 'Para türü (nakit, banka, kripto)' },
                amount = { name = 'amount', help = 'Verilecek para miktarı' },
            },
        },
        setmoney = {
            help = 'Oyuncunun Para Miktarını Ayarla (Sadece Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                moneytype = { name = 'moneytype', help = 'Para türü (nakit, banka, kripto)' },
                amount = { name = 'amount', help = 'Para miktarı' },
            },
        },
        job = { help = 'İşinizi Kontrol Edin' },
        setjob = {
            help = 'Bir Oyuncunun İşini Ayarla (Sadece Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                job = { name = 'job', help = 'İş adı' },
                grade = { name = 'grade', help = 'İş seviyesi' },
            },
        },
        gang = { help = 'Çetenizi Kontrol Edin' },
        setgang = {
            help = 'Bir Oyuncunun Çetesini Ayarla (Sadece Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                gang = { name = 'gang', help = 'Çete adı' },
                grade = { name = 'grade', help = 'Çete seviyesi' },
            },
        },
        ooc = { help = 'OOC Sohbet Mesajı' },
        me = {
            help = 'Yerel mesaj gönder',
            params = {
                message = { name = 'message', help = 'Gönderilecek mesaj' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

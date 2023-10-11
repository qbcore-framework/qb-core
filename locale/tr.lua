local Translations = {
    error = {
        not_online = 'Oyuncu çevrimdışı',
        wrong_format = 'Yanlış biçim',
        missing_args = 'Her argüman girilmemiş (x, y, z)',
        missing_args2 = 'Tüm argümanlar doldurulmalıdır!',
        no_access = 'Bu komuta erişim yok',
        company_too_poor = 'İşvereniniz iflas etti',
        item_not_exist = 'Öğe mevcut değil',
        too_heavy = 'Envanter çok dolu',
        location_not_exist = 'Konum mevcut değil',
        duplicate_license = '[QBCORE] - Yine Rockstar Lisansı Bulundu',
        no_valid_license  = '[QBCORE] - Geçerli Rockstar Lisansı Bulunamadı',
        not_whitelisted = '[QBCORE] - Bu sunucu için beyaz listeye alınmadınız',
        server_already_open = 'Sunucu zaten açık',
        server_already_closed = 'Sunucu zaten kapalı',
        no_permission = 'Bunun için izniniz yok..',
        no_waypoint = 'Waypoint belirtilmedi.',
        tp_error = 'Teleport yaparken hata oluştu.',
        connecting_database_error = '[QBCORE] - Sunucuya bağlanırken veritabanı hatası oluştu. (SQL sunucu açık mı?)',
        connecting_database_timeout = '[QBCORE] - Veritabanına bağlantı zaman aşımına uğradı. (SQL sunucu açık mı?)',
    },
    success = {
        server_opened = 'Sunucu açıldı',
        server_closed = 'Sunucu kapatıldı',
        teleported_waypoint = 'Waypoint\'e teleport edildi.',
    },
    info = {
        received_paycheck = 'Maaşınızı aldınız: $%{value}',
        job_info = 'İş: %{value} | Derece: %{value2} | Görev: %{value3}',
        gang_info = 'Çete: %{value} | Derece: %{value2}',
        on_duty = 'Artık görevdesiniz!',
        off_duty = 'Artık görevde değilsiniz!',
        checking_ban = 'Merhaba %s. Yasaklı olup olmadığınızı kontrol ediyoruz.',
        join_server = 'Hoş geldiniz %s, {Sunucu Adı} sunucusuna.',
        checking_whitelisted = 'Merhaba %s. İzninizin kontrol ediliyor.',
        exploit_banned = 'Hile yaptığınız için yasaklandınız. Daha fazla bilgi için Discord\'umuzu kontrol edin: %{discord}',
        exploit_dropped = 'Hile yapmaktan atıldınız',
    },
    command = {
        tp = {
            help = 'Oyuncuya veya koordinatlara TP yap (Yalnızca Admin)',
            params = {
                x = { name = 'id/x', help = 'Oyuncu ID\'si veya X pozisyonu'},
                y = { name = 'y', help = 'Y pozisyonu'},
                z = { name = 'z', help = 'Z pozisyonu'},
            },
        },
        tpm = { help = 'İşaretçiye TP yap (Yalnızca Admin)' },
        togglepvp = { help = 'Sunucuda PVP\'yi Aç/Kapat (Yalnızca Admin)' },
        addpermission = {
            help = 'Oyuncuya izin ver (Yalnızca Tanrı)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                permission = { name = 'izin', help = 'İzin seviyesi' },
            },
        },
        removepermission = {
            help = 'Oyuncu izinlerini kaldır (Yalnızca Tanrı)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                permission = { name = 'izin', help = 'İzin seviyesi' },
            },
        },
        openserver = { help = 'Sunucuyu herkese aç (Yalnızca Admin)' },
        closeserver = {
            help = 'İzin olmayanlar için sunucuyu kapat (Yalnızca Admin)',
            params = {
                reason = { name = 'sebep', help = 'Kapatma nedeni (isteğe bağlı)' },
            },
        },
        car = {
            help = 'Araç oluştur (Yalnızca Admin)',
            params = {
                model = { name = 'model', help = 'Araç modeli adı' },
            },
        },
        dv = { help = 'Araç sil (Yalnızca Admin)' },
        givemoney = {
            help = 'Bir oyuncuya para ver (Yalnızca Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                moneytype = { name = 'para_türü', help = 'Para türü (nakit, banka, kripto)' },
                amount = { name = 'miktar', help = 'Para miktarı' },
            },
        },
        setmoney = {
            help = 'Oyuncunun para miktarını ayarla (Yalnızca Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                moneytype = { name = 'para_türü', help = 'Para türü (nakit, banka, kripto)' },
                amount = { name = 'miktar', help = 'Para miktarı' },
            },
        },
        job = { help = 'İşinizi kontrol edin' },
        setjob = {
            help = 'Bir oyuncunun işini ayarla (Yalnızca Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                job = { name = 'iş', help = 'İş adı' },
                grade = { name = 'derece', help = 'İş derecesi' },
            },
        },
        gang = { help = 'Çetenizi kontrol edin' },
        setgang = {
            help = 'Bir oyuncunun çetesini ayarla (Yalnızca Admin)',
            params = {
                id = { name = 'id', help = 'Oyuncu ID\'si' },
                gang = { name = 'çete', help = 'Çete adı' },
                grade = { name = 'derece', help = 'Çete derecesi' },
            },
        },
        ooc = { help = 'OOC Sohbet Mesajı' },
        me = {
            help = 'Yerel mesajı göster',
            params = {
                message = { name = 'mesaj', help = 'Gönderilecek mesaj' }
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

local Translations = {
    error = {
        not_online = 'Oyuncu çevrimiçi değil.',
        wrong_format = 'Yanlış format.',
        missing_args = 'Hiçbir argüman girilmedi. (x, y, z)',
        missing_args2 = 'Tüm argümanlar doldurulmalıdır.',
        no_access = 'Bu komuta erişimin yok.',
        company_too_poor = 'Şirketin hiç parası yok.',
        item_not_exist = 'Eşya mevcut değil.',
        too_heavy = 'Envanter çok dolu',
        duplicate_license = 'Çoğaltılan Rockstar lisans bulundu!',
        no_valid_license  = 'Rockstar lisans bulunamadı.',
        not_whitelisted = 'Bu sunucuda whitelistin yok.'
    },
    success = {},
    info = {
        received_paycheck = 'Maaş çekinizi aldınız $%{value}',
        job_info = 'İş: %{value} | Seviye: %{value2} | Görev: %{value3}',
        gang_info = 'Çete: %{value} | Seviye: %{value2}',
        on_duty = 'Şimdi görev başındasın!',
        off_duty = 'Şimdi görevden alındın!',
        checking_ban = 'Merhaba %s. Banlı mısın diye kontrol ediyoruz.',
        join_server = 'Merhaba %s. {Server Name} adlı sunucumuza hoş geldin.',
        checking_whitelisted = 'Merhaba %s. Giriş iznin var mı diye kontrol ediyoruz.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

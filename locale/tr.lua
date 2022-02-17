local Translations = {
    error = {
        not_online = 'Oyuncu çevrimiçi değil',
        wrong_format = 'Yanlış birim',
        missing_args = 'Her argüman girilmedi (x, y, z)',
        missing_args2 = 'Tüm argümanlar doldurulmalıdır!',
        no_access = 'Bu komuta erişim yok',
        company_too_poor = 'İşvereniniz bozuk',
        item_not_exist = 'Öğe mevcut değil',
        too_heavy = 'Envanter çok dolu'
    },
    success = {},
    info = {
        received_paycheck = 'Maaş çekinizi aldınız $%{value}',
        job_info = 'İş: %{value} | Seviye: %{value2} | Görev: %{value3}',
        gang_info = 'Çete: %{value} | Seviye: %{value2}',
        on_duty = 'Şimdi görev başındasın!',
        off_duty = 'Şimdi görevden alındın!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

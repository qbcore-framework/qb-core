local Translations = {
    error = {
        not_online = 'Oyuncu açık değil',
        wrong_format = 'Yanlış format',
        missing_args = 'Her argüman girilmedi (x, y, z)',
        missing_args2 = 'Tüm argümanlar doldurulmalıdır!',
        no_access = 'Bu komuta erişim yok',
        company_too_poor = 'İşvereniniz bozuk',
        item_not_exist = 'Eşya mevcut değil',
        too_heavy = 'Envanter çok dolu'
    },
    success = {},
    info = {
        received_paycheck = '$%{value} maaş çeki aldınız',
        job_info = 'Meslek: %{value} | Seviye: %{value2} | Mesai: %{value3}',
        gang_info = 'Çete: %{value} | Seviye: %{value2}',
        on_duty = 'Artık mesaidesiniz!',
        off_duty = 'Mesaide değilsiniz!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

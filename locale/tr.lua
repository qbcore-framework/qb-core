local Translations = {
    error = {
        not_online = 'Oyuncu online değil',
        wrong_format = 'Geçersiz format',
        missing_args = 'Tüm argüman girilmedi (x, y, z)',
        missing_args2 = 'Tüm argumanlar doldurulmalıdır!',
        no_access = 'Bu komuta yetkin yok',
        company_too_poor = 'İşverinin kırıldı',
        item_not_exist = 'Geçersiz item',
        too_heavy = 'Envanterin dolu'
    },
    success = {},
    info = {
        received_paycheck = 'Maaşın yatırıldı $%{value}',
        job_info = 'Meslek: %{value} | Seviye: %{value2} | Mesai: %{value3}',
        gang_info = 'Gang: %{value} | Seviye: %{value2}',
        on_duty = 'Mesaiye başladın!',
        off_duty = 'Mesaiden çıktın!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
    error = {
        not_online = 'Oyuncu çevrimiçi değil.',
        wrong_format = 'Argümanlar yanlış formatta doldurulmuş.',
        missing_args = 'Doğru koordinatlar girilmedi (x, y, z)',
        missing_args2 = 'Tüm argümanlar doldurulmalı!',
        no_access = 'Komut için yetkili değilsiniz.',
        company_too_poor = 'İşveren kurum ve kuruluş iflas etmiş.',
        item_not_exist = 'Böyle bir eşya bulunmamaktadır.',
        too_heavy = 'Envanteriniz dolu gözüküyor.'
    },
    success = {},
    info = {
        received_paycheck = '$%{value} Değerinde maaş çekinizi aldınız.',
        job_info = 'İş: %{value} | Seviye: %{value2} | Görev: %{value3}',
        gang_info = 'Çete: %{value} | Seviye: %{value2}',
        on_duty = 'Göreve başladınız.',
        off_duty = 'Artık görevde değilsin.'
    }
}

--         on_duty = 'Göreve başladınız.',
--         off_duty = 'Artık görevde değilsin.'
-- Komut satırında bulunan alanlar mesai mantığında değerlendirilebilir. 
-- Dolayısıyla: 
--         on_duty = 'Mesaiye başladınız.',
--         off_duty = 'Mesai sona erdi.' 
-- Mantığında çeşitli varyasyonlarda değerlendirilebilir.
-- 	fxmanifest içerisinden 'locale/en.lua', kısmını.
-- 'locale/tr.lua' şeklinde ayarlamayı unutmayınız.

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

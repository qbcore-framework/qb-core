local Translations = {
    error = {
        not_online = 'Pemain tidak online',
        wrong_format = 'Format salah',
        missing_args = 'Tidak semua argumen telah dimasukkan (x, y, z)',
        missing_args2 = 'Semua argumen harus diisi!',
        no_access = 'Tidak ada akses ke perintah ini',
        company_too_poor = 'Majikan kamu bangkrut',
        item_not_exist = 'Barang tidak tersedia',
        too_heavy = 'Inventory terlalu penuh'
    },
    success = {},
    info = {
        received_paycheck = 'Kamu menerima gaji kamu sebesar $%{value}',
        job_info = 'Pekerjaan: %{value} | Pangkat: %{value2} | Bertugas: %{value3}',
        gang_info = 'Gang: %{value} | Pangkat: %{value2}',
        on_duty = 'Kamu sekarang sedang bertugas!',
        off_duty = 'Kamu sekarang sedang tidak bertugas!'
    }
}

if GetConvar('qb_locale', 'en') == 'in' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

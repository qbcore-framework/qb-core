local Translations = {
    error = {
        not_online = 'Pemain tidak online',
        wrong_format = 'Format Salah',
        missing_args = 'Semua argumen belum dimasukkan (x, y, z)',
        missing_args2 = 'Semua argumen harus diisi!',
        no_access = 'Kamu tidak memiliki akses ke perintah ini',
        company_too_poor = 'Perusahaan kamu tidak mampu membayar kamu',
        item_not_exist = 'Barang tidak tersedia',
        too_heavy = 'Inventory terlalu penuh',
        location_not_exist = 'Lokasi tidak tersedia',
        duplicate_license = 'Ditemukan Lisensi Rockstar Duplikat',
        no_valid_license  = 'Tidak Ditemukan Lisensi Rockstar yang Valid',
        not_whitelisted = 'Kamu tidak masuk daftar putih untuk server ini',
        server_already_open = 'Server sudah terbuka',
        server_already_closed = 'Server sudah ditutup',
        no_permission = 'Kamu tidak memiliki izin untuk ini..',
        no_waypoint = 'Tidak ada Titik Arah yang Ditetapkan.',
        tp_error = 'Kesalahan saat teleportasi.',
        connecting_database_error = 'Terjadi kesalahan database saat menghubungkan ke server. (Apakah server SQL aktif?)',
        connecting_database_timeout = 'Waktu koneksi ke database habis. (Apakah server SQL aktif?)',
    },
    success = {
        server_opened = 'Server telah dibuka',
        server_closed = 'Server telah ditutup',
        teleported_waypoint = 'Diteleportasi ke Titik Arah.',
    },
    info = {
        received_paycheck = 'Kamu telah menerima gaji $%{value}',
        job_info = 'Pekerjaan: %{value} | Pangkat: %{value2} | Tugas: %{value3}',
        gang_info = 'Geng: %{value} | Pangkat: %{value2}',
        on_duty = 'Kamu sekarang sedang bertugas!',
        off_duty = 'Kamu sekarang sedang tidak bertugas!',
        checking_ban = 'Halo %s. Kami sedang memeriksa apakah kamu dilarang.',
        join_server = 'Selamat datang %s di {Server Name}.',
        checking_whitelisted = 'Halo %s. Kami sedang memeriksa apakah kamu masuk daftar putih',
        exploit_banned = 'Kamu telah dilarang karena curang. Lihat Discord kami untuk informasi lebih lanjut: %{discord}',
        exploit_dropped = 'Kamu telah dikeluarkan dari server karena eksploitasi',
    },
    command = {
        tp = {
            help = 'TP Ke Pemain atau Koord (Khusus Admin)',
            params = {
                x = { name = 'id/x', help = 'ID pemain atau posisi X'},
                y = { name = 'y', help = 'posisi Y'},
                z = { name = 'z', help = 'posisi Z'},
            },
        },
        tpm = { help = 'TP Ke Penanda (Khusus Admin)' },
        togglepvp = { help = 'Tombol PVP di server (Khusus Admin)' },
        addpermission = {
            help = 'Berikan Izin Pemain (Khusus Pemilik)',
            params = {
                id = { name = 'id', help = 'ID pemain' },
                permission = { name = 'permission', help = 'Tingkat izin' },
            },
        },
        removepermission = {
            help = 'Hapus Izin Pemain (Khusus Pemilik)',
            params = {
                id = { name = 'id', help = 'ID pemain' },
                permission = { name = 'permission', help = 'Tingkat izin' },
            },
        },
        openserver = { help = 'Buka server untuk semua orang (Khusus Admin)' },
        closeserver = {
            help = 'Tutup server untuk orang tanpa izin (Khusus Admin)',
            params = {
                reason = { name = 'reason', help = 'Alasan penutupan (opsional)' },
            },
        },
        car = {
            help = 'Memunculkan Kendaraan (Khusus Admin)',
            params = {
                model = { name = 'model', help = 'Nama model kendaraan' },
            },
        },
        dv = { help = 'Hapus Kendaraan (Khusus Admin)' },
        givemoney = {
            help = 'Beri Pemain Uang (Khusus Admin)',
            params = {
                id = { name = 'id', help = 'ID pemain' },
                moneytype = { name = 'moneytype', help = 'Jenis uang (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Jumlah uang' },
            },
        },
        setmoney = {
            help = 'Tetapkan Jumlah Uang Pemain (Khusus Admin)',
            params = {
                id = { name = 'id', help = 'ID pemain' },
                moneytype = { name = 'moneytype', help = 'Jenis uang (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Jumlah uang' },
            },
        },
        job = { help = 'Periksa Pekerjaan Kamu' },
        setjob = {
            help = 'Tetapkan Pekerjaan Pemain (Khusus Admin)',
            params = {
                id = { name = 'id', help = 'ID pemain' },
                job = { name = 'job', help = 'Nama pekerjaan' },
                grade = { name = 'grade', help = 'Pangkat pekerjaan' },
            },
        },
        gang = { help = 'Periksa Geng Kamu' },
        setgang = {
            help = 'Tetapkan Geng Pemain (Khusus Admin)',
            params = {
                id = { name = 'id', help = 'ID pemain' },
                gang = { name = 'gang', help = 'Nama geng' },
                grade = { name = 'grade', help = 'Pangkat geng' },
            },
        },
        ooc = { help = 'Pesan Obrolan OOC' },
        me = {
            help = 'Tampilkan pesan lokal',
            params = {
                message = { name = 'message', help = 'Pesan yang akan dikirim' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'id' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

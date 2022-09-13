local Translations = {
    error = {
        not_online = 'Người chơi không trực tuyến',
        wrong_format = 'Định dạng không chính xác',
        missing_args = 'chưa nhập đủ các số (x, y, z)',
        missing_args2 = 'Tất cả các đối số phải được điền vào!',
        no_access = 'không có quyền sử dụng lệnh này',
        company_too_poor = 'Công ty của bạn đã phá sản',
        item_not_exist = 'Vật phẩm không tồn tại',
        too_heavy = 'kho đồ đã đầy'
    },
    success = {},
    info = {
        received_paycheck = 'bạn nhận được sốt tiền thanh toán là $%{value}',
        job_info = 'Công việc: %{value} | Cấp độ: %{value2} | Làm việc: %{value3}',
        gang_info = 'Băng đảng: %{value} | Cấp độ: %{value2}',
        on_duty = 'Bạn đã sẵn sàng làm viêc!',
        off_duty = 'Bạn đã dừng làm việc!'
    }
}

if GetConvar('qb_locale', 'en') == 'vn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

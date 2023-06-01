local Translations = {
    error = {
        not_online = 'Người chơi không trực tuyến',
        wrong_format = 'Định dạng không chính xác',
        missing_args = 'Chưa nhập đủ các số (x, y, z)',
        missing_args2 = 'Tất cả các đối số phải được điền vào!',
        no_access = 'không có quyền sử dụng lệnh này',
        company_too_poor = 'Công ty của bạn đã phá sản',
        item_not_exist = 'Vật phẩm không tồn tại',
        too_heavy = 'kho đồ đã đầy',
        location_not_exist = 'Vị trí không tồn tại',
        duplicate_license = 'Đã tìm thấy giấy phép Rockstar trùng lặp',
        no_valid_license  = 'Không tìm thấy giấy phép Rockstar hợp lệ',
        not_whitelisted = 'Bạn không nằm trong danh sách cho phép của máy chủ này',
        server_already_open = 'Máy chủ đã mở cửa',
        server_already_closed = 'Máy chủ đã đóng cửa',
        no_permission = 'Bạn không có quyền để làm việc này',
        no_waypoint = 'Không có Waypoint nào được đặt.',
        tp_error = 'Lỗi trong lúc dịch chuyển.',
        connecting_database_error = 'Đã xảy ra lỗi trong lúc kết nối đến máy chủ CSDL. (Máy chủ SQL đã mở?)',
        connecting_database_timeout = 'Đã hết thời gian kết nối tới CSDL. (Máy chủ SQL đã mở?)',
    },
    success = {
        server_opened = 'Đã mở máy chủ',
        server_closed = 'Đã đóng máy chủ',
        teleported_waypoint = 'Đã dịch chuyển tới Waypoint.',
    },
    info = {
        received_paycheck = 'Bạn nhận được số tiền thanh toán là $%{value}',
        job_info = 'Công việc: %{value} | Cấp độ: %{value2} | Làm việc: %{value3}',
        gang_info = 'Băng đảng: %{value} | Cấp độ: %{value2}',
        on_duty = 'Bạn đã sẵn sàng làm viêc!',
        off_duty = 'Bạn đã dừng làm việc!',
        checking_ban = 'Xin chào %s. Chúng tôi đang kiểm tra xem bạn có bị cấm không.',
        join_server = 'Chào mừng %s đã đến với {Server Name}.',
        checking_whitelisted = 'Xin chào %s. Chúng tôi đang kiểm tra trợ cấp của bạn.',
        exploit_banned = 'Bạn đã bị cấm vì gian lận. Kiểm tra Discord của chúng tôi để biết thêm thông tin: %{discord}',
        exploit_dropped = 'Bạn đã bị đá vì lợi dụng lỗi',
    },
    command = {
        tp = {
            help = 'Dịch chuyển đến Người chơi hoặc Tọa độ (Admin)',
            params = {
                x = { name = 'id/x', help = 'ID người chơi hoặc Tọa độ X'},
                y = { name = 'y', help = 'Tọa độ Y'},
                z = { name = 'z', help = 'Tọa độ Z'},
            },
        },
        tpm = { help = 'Dịch chuyển đến điểm Đánh dấu (Admin)' },
        togglepvp = { help = 'Bật/Tắt PVP trên máy chủ (Admin)' },
        addpermission = {
            help = 'Thêm quyền cho người chơi (God)',
            params = {
                id = { name = 'id', help = 'ID người chơi' },
                permission = { name = 'permission', help = 'Cấp độ quyền' },
            },
        },
        removepermission = {
            help = 'Xóa quyền của người chơi (God)',
            params = {
                id = { name = 'id', help = 'ID người chơi' },
                permission = { name = 'permission', help = 'Cấp độ quyền' },
            },
        },
        openserver = { help = 'Mở cửa máy chủ (Admin)' },
        closeserver = {
            help = 'Đóng máy chủ, chỉ cho phép người chơi có quyền mới được tham gia (Admin)',
            params = {
                reason = { name = 'reason', help = 'Lý do đóng máy chủ (tùy chọn)' },
            },
        },
        car = {
            help = 'Triệu hồi phương tiện (Admin)',
            params = {
                model = { name = 'model', help = 'Tên kiểu phương tiện' },
            },
        },
        dv = { help = 'Xóa phương tiện (Admin)' },
        givemoney = {
            help = 'Cho tiền người chơi (Admin)',
            params = {
                id = { name = 'id', help = 'ID người chơi' },
                moneytype = { name = 'moneytype', help = 'Loại tiền (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Số tiền' },
            },
        },
        setmoney = {
            help = 'Đặt số tiền của người chơi (Admin)',
            params = {
                id = { name = 'id', help = 'ID người chơi' },
                moneytype = { name = 'moneytype', help = 'Loại tiền (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Số tiền' },
            },
        },
        job = { help = 'Kiểm tra công việc của bạn' },
        setjob = {
            help = 'Đặt công việc cho ngưởi chơi (Admin)',
            params = {
                id = { name = 'id', help = 'ID người chơi' },
                job = { name = 'job', help = 'Tên công việc' },
                grade = { name = 'grade', help = 'Cấp độ công việc' },
            },
        },
        gang = { help = 'Kiểm tra băng đảng của bạn' },
        setgang = {
            help = 'Chỉ định băng đảng cho người chơi (Admin)',
            params = {
                id = { name = 'id', help = 'ID người chơi' },
                gang = { name = 'gang', help = 'Tên băng đảng' },
                grade = { name = 'grade', help = 'Cấp độ chức vụ' },
            },
        },
        ooc = { help = 'Tin nhắn trò chuyện OOC' },
        me = {
            help = 'Hiển thị tin nhắn cục bộ',
            params = {
                message = { name = 'message', help = 'Tin nhắn để gửi' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'vn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

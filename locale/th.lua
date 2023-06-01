local Translations = {
    error = {
        not_online = 'ผู้เล่นไม่ออนไลน์',
        wrong_format = 'รูปแบบไม่ถูกต้อง',
        missing_args = 'ตัวแปรที่ต้องการไม่ถูกกำหนด (x, y, z)',
        missing_args2 = 'ต้องกำหนดตัวแปรทุกตัวให้ครบ!',
        no_access = 'ไม่สามารถเข้าถึงคำสั่งนี้ได้',
        company_too_poor = 'บริษัทของคุณกำลังจะล้มละลาย',
        item_not_exist = 'ไม่มีไอเทมนี้',
        too_heavy = 'กระเป๋าเต็มแล้ว',
        location_not_exist = 'ไม่มีตำแหน่งนี้',
        duplicate_license = 'พบใบอนุญาต Rockstar ซ้ำ',
        no_valid_license  = 'ไม่พบใบอนุญาต Rockstar ที่ถูกต้อง',
        not_whitelisted = 'คุณไม่ได้รับอนุญาตให้เข้าใช้เซิร์ฟเวอร์นี้',
        server_already_open = 'เซิร์ฟเวอร์ถูกเปิดแล้ว',
        server_already_closed = 'เซิร์ฟเวอร์ถูกปิดแล้ว',
        no_permission = 'คุณไม่ได้รับสิทธิ์ในการใช้คำสั่งนี้..',
        no_waypoint = 'ไม่มีจุดเส้นทางที่ตั้ง',
        tp_error = 'ข้อผิดพลาดขณะวาร์ป',
        connecting_database_error = 'เกิดข้อผิดพลาดในการเชื่อมต่อกับเซิร์ฟเวอร์ (SQL server เปิดอยู่ไหม?)',
        connecting_database_timeout = 'เชื่อมต่อกับฐานข้อมูลเกิด timeout (SQL server เปิดอยู่ไหม?'
    },
    success = {
        server_opened = 'เซิฟเวอร์เปิดแล้ว',
        server_closed = 'เซิฟเวอร์เปิดแล้ว',
        teleported_waypoint = 'เคลือนย้ายไปยังจุดหมาย.',
    },
    info = {
        received_paycheck = 'คุณได้รับเงินเดือน $%{value}',
        job_info = 'อาชีพ: %{value} | ระดับ: %{value2} | กำลังปฏิบัติหน้าที่: %{value3}',
        gang_info = 'แก๊ง: %{value} | ระดับ: %{value2}',
        on_duty = 'คุณเริ่มปฏิบัติหน้าที่แล้ว!',
        off_duty = 'คุณออกจากการปฏิบัติหน้าที่แล้ว!',
        checking_ban = 'สวัสดี %s. เรากำลังตรวจสอบสถานะการโดนแบนของคุณ.',
        join_server = 'ยินดีต้อนรับ %s เข้าสู่ {Server Name}.',
        checking_whitelisted = 'สัวสดี %s. เรากำลังเช็ค whitelisted ของคุณ.',
        exploit_banned = 'คุณโดนแบนจากการโกง. เข้าร่วม Discord สำหรับข้อมูลเพิ่มเติม: %{discord}',
        exploit_dropped = 'คุณโดนเตะออกจากเซิฟเวอร์ เนื่องจากเหตุผลเกี่ยวกับการใช้โปรแกรมโกง',
    },
    command = {
        tp = {
            help = 'เคลือนย้ายไปยัง ผู้เล่น หรือ ตำแหน่งพิกัด (สำหรับ Admin)',
            params = {
                x = { name = 'id/x', help = 'ไอดีของผู้เล่น หรือ พิกัด x'},
                y = { name = 'y', help = 'พิกัด y'},
                z = { name = 'z', help = 'พิกัด z'},
            },
        },
        tpm = { help = 'เคลือนย้ายไปบังจุดมาร์ค (สำหรับ Admin)' },
        togglepvp = { help = 'เปิดใช้ pvp ในเซิฟเวอร์ (สำหรับ Admin)' },
        addpermission = {
            help = 'ให้สิทธิ์กับผู้เล่น (สำหรับ God)',
            params = {
                id = { name = 'id', help = 'ไอดีของผู้เล่น' },
                permission = { name = 'permission', help = 'ระดับของสิทธิ์' },
            },
        },
        removepermission = {
            help = 'ลบสิทธิ์ของผู้เล่น (สำหรับ God)',
            params = {
                id = { name = 'id', help = 'ID of player' },
                permission = { name = 'permission', help = 'ระดับของสิทธิ์' },
            },
        },
        openserver = { help = 'เปิดเซิฟเวอร์สำหรับทุกคน (สำหรับ Admin)' },
        closeserver = {
            help = 'ปิดเซิฟเวอร์สำหรับทุกคนที่ไม่มีสิทธิ์การเข้าถึง (สำหรับ Admin)',
            params = {
                reason = { name = 'reason', help = 'เหตุผลที่ปิด (ถ้ามี)' },
            },
        },
        car = {
            help = 'เรียกยานพาหนะ (สำหรับ Admin)',
            params = {
                model = { name = 'model', help = 'ชื่อของยานพาหนะ' },
            },
        },
        dv = { help = 'ลบยานพาหนะ (สำหรับ Admin)' },
        givemoney = {
            help = 'ให้เงินกับผู้เล่น (สำหรับ Admin)',
            params = {
                id = { name = 'id', help = 'ไอดีของผู้เล่น' },
                moneytype = { name = 'moneytype', help = 'ประเภทของเงิน (เงินสด, เงินฝาก, คริปโต)' },
                amount = { name = 'amount', help = 'จำนวนเงิน' },
            },
        },
        setmoney = {
            help = 'กำหนดจำนวนเงินของผู้เล่น (สำหรับ Admin)',
            params = {
                id = { name = 'id', help = 'ไอดีของผู้เล่น' },
                moneytype = { name = 'moneytype', help = 'ประเภทของเงิน (เงินสด, เงินฝาก, คริปโต)' },
                amount = { name = 'amount', help = 'จำนวนเงิน' },
            },
        },
        job = { help = 'ตรวจสอบอาชีพของคุณ' },
        setjob = {
            help = 'กำหนดอาชีพของผู้เล่น (สำหรับ Admin)',
            params = {
                id = { name = 'id', help = 'ไอดีของผู้เล่น' },
                job = { name = 'job', help = 'ชื่ออาชีพ่' },
                grade = { name = 'grade', help = 'ระดับ' },
            },
        },
        gang = { help = 'ตรวจสอบแก๊งของคุณ' },
        setgang = {
            help = 'กำหนดแก๊งของผู้เล่น (สำหรับ Admin)',
            params = {
                id = { name = 'id', help = 'ไอดีของผู้เล่น' },
                gang = { name = 'gang', help = 'ชื่อแก๊ง' },
                grade = { name = 'grade', help = 'ระดับ' },
            },
        },
        ooc = { help = 'ข้อความ OOC' },
        me = {
            help = 'แสดงข้อความใกล้เขียง',
            params = {
                message = { name = 'message', help = 'ข้อความที่จะส่ง' }
            },
        },
    }
}
    
if GetConvar('qb_locale', 'en') == 'th' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

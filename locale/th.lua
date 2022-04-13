local Translations = {
    error = {
        not_online = 'ผู้เล่นไม่ออนไลน์',
        wrong_format = 'รูปแบบไม่ถูกต้อง',
        missing_args = 'ไม่ได้ป้อนทุกอาร์กิวเมนต์ (x, y, z)',
        missing_args2 = 'จะต้องกรอกอาร์กิวเมนต์ทั้งหมด',
        no_access = 'ไม่มีสิทธิ์เข้าถึงคำสั่งนี้',
        company_too_poor = 'ผู้ว่าจ้างของคุณยากจนมาก',
        item_not_exist = 'ไม่มีรายการนี้',
        too_heavy = 'สินค้าในคลังเต็มแล้ว'
    },
    success = {},
    info = {
        received_paycheck = 'คุณได้รับเงินเดือนเป็นเงิน $%{value}',
        job_info = 'อาชีพ: %{value} | ระดับ: %{value2} | อยู่ในหน้าที่: %{value3}',
        gang_info = 'แก๊ง: %{value} | ระดับ: %{value2}',
        on_duty = 'ตอนนี้คุณอยู่ในหน้าที่แล้ว',
        off_duty = 'ตอนนี้คุณออกหน้าที่แล้ว'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

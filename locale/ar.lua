local Translations = {
    error = {
        not_online = 'اللاعب غير متصل',
        wrong_format = 'خطأ في المعلومات',
        missing_args = '(x, y, z) يجب ادخال كل من',
        missing_args2 = 'يجب ملء جميع الحقول',
        no_access = 'لا يمكن الوصول إلى هذا الأمر',
        company_too_poor = 'صاحب العمل مفلس',
        item_not_exist = 'العنصر غير موجود',
        too_heavy = 'الحقيبة ممتلئة للغاية'
    },
    success = {},
    info = {
        received_paycheck = 'لقد تلقيت راتبك $%{value}',
        job_info = '%{value} | %{value2} | %{value3} حالة الخدمة:',
        gang_info = '%{value} | %{value2}',
        on_duty = 'أنت الآن داخل الخدمة',
        off_duty = 'أنت الأن حارج الخدمة'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
    error = {
        not_online = 'اللاعب غير متصل',
        wrong_format = 'التنسيق غير صحيح',
        missing_args = '(x, y, z) لم يتم ادخل جميع المعلومات',
        missing_args2 = 'يجب ملأ جميع الحقول اللازمة',
        no_access = 'لا يمكن الوصول إلى هذا الأمر',
        company_too_poor = 'مسؤول الوظيفة لا يمكلك مال كاف-ي',
        item_not_exist = 'عنصر غير موجود',
        too_heavy = 'لا يوجد مساحة في جقيبتك'
    },
    success = {},
    info = {
        received_paycheck = '$%{value} لقد استملت راتبك الشهري',
        job_info = '%{value} | %{value2} | %{value3}',
        gang_info = '%{value} | %{value2}',
        on_duty = 'انت الان خارج الخدمة',
        off_duty = 'انت الان في الخدمة'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

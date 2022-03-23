local Translations = {
    error = {
        not_online = 'اللاعب غير متواجد',
        wrong_format = 'التنسيق غير صحيح',
        missing_args = 'لم يتم ادخل جميع الحقول تاكد من وضع (x, y, z)',
        missing_args2 = 'يجب ملأ جميع الحقول اللازمة!',
        no_access = 'لا يمكن الوصول إلى هذا الأمر',
        company_too_poor = 'رئيس العمل الخاص بك لا يملك اموال كافية',
        item_not_exist = 'لا يوجد هذا العنصر',
        too_heavy = 'المحفظة ممتلئة'
    },
    success = {},
    info = {
        received_paycheck = 'لقد استملت راتبك الشهري $%{value}',
        job_info = 'الوظيفة: %{value} | الرتبة: %{value2} | الخدمة: %{value3}',
        gang_info = 'العصابة: %{value} | الرتبة: %{value2}',
        on_duty = 'انت الان خارج الخدمة!',
        off_duty = 'انت الان في الخدمة!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

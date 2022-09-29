local Translations = {
    error = {
        not_online = 'اللاعب غير متصل',
        wrong_format = 'التنسيق غير صحيح',
        missing_args = '(x, y, z) لم يتم ادخل جميع المعلومات',
        missing_args2 = 'يجب ملأ جميع الحقول اللازمة',
        no_access = 'لا يمكن الوصول إلى هذا الأمر',
        company_too_poor = 'مسؤول الوظيفة لا يمكلك مال كافي',
        item_not_exist = 'عنصر غير موجود',
        too_heavy = 'لا يوجد مساحة في جقيبتك',
		location_not_exist = 'الموقع غير موجود',
        duplicate_license = 'وجدنا ترخيص روكستار مكرر او موجود مسبقا',
        no_valid_license  = 'ترخيص روكستار غير صحيح',
        not_whitelisted = 'عضويتك غير مفعلة في هذا السيرفر',
		server_already_open = 'السيرفر مفتووح',
        server_already_closed = 'السيرفر مغلق',
        no_permission = 'لاتمتلك الصلاحية',
        no_waypoint = 'لم يتم تحديد الاتجاه.',
        tp_error = 'خطأ اثناء الانتقال.',
    },
	success = {
        server_opened = 'تم فتح السيرفر',
        server_closed = 'تم غلق السيرفر',
        teleported_waypoint = 'تم الانتقال الي الاتجاه المحدد.',
    },
    info = {
        received_paycheck = '$%{value} لقد استملت راتبك الشهري',
        job_info = '%{value} | %{value2} | %{value3}',
        gang_info = '%{value} | %{value2}',
        on_duty = 'انت الان في الخدمة',
        off_duty = 'انت الان خارج الخدمة',
        checking_ban = 'نحن نتحقق اذا كنت محجوب من السيرفر. %s مرحبا',
        join_server = '{Server Name} في %s مرحبا',
        checking_whitelisted = 'نتحقق ما اذا كان مسموح لك بالدخول %s مرحبا',
        exploit_banned = 'لقد تم حجبك من السيرفر بسبب الغش ان كانت لديك اية تساؤلات اتصل بنا عبر ديسكورد السيرفر: %{discord}',
        exploit_dropped = 'لقد تم طردك من السيرفر بسبب استغلالك بعض الثغرات',
    },
	command = {
        tp = {
            help = 'الانتقال الي نقطة او إلى لاعب (إدارة فقط)',
            params = {
                x = { name = 'id/x', help = 'ايدي اللاعب او قيمة x'},
                y = { name = 'y', help = 'Y القيمة'},
                z = { name = 'z', help = 'Z القيمة'},
            },
        },
        tpm = { help = 'الانتقال الي النقطة المحددة (إدارة فقط)' },
        togglepvp = { help = 'تبديل وضع PVP في السيرفر (إدارة فقط)' },
        addpermission = {
            help = 'إعطاء صلاحية للاعب (إدارة عليا)',
            params = {
                id = { name = 'id', help = 'آيدي اللاعب' },
                permission = { name = 'permission', help = 'مستوى الصلاحية او الرتبة' },
            },
        },
        removepermission = {
            help = 'سحب صلاحية من لاعب (إدارة عليا)',
            params = {
                id = { name = 'id', help = 'آيدي اللاعب' },
                permission = { name = 'permission', help = 'مستوى الصلاحية او الرتبة' },
            },
        },
        openserver = { help = 'جعل السيرفر مفتح للكل (إدارة فقط)' },
        closeserver = {
            help = 'إغلاق السيرفر بالنسبة للاشخاص الذين ليست لديهم اية صلاحية (إدارة فقط)',
            params = {
                reason = { name = 'reason', help = 'سبب الغلق (إختياري)' },
            },
        },
        car = {
            help = 'رسبنة سيارة (إدارة فقط)',
            params = {
                model = { name = 'model', help = 'اسم موديل السيارة' },
            },
        },
        dv = { help = 'حذف السيارة (إدارة فقط)' },
        givemoney = {
            help = 'اضافة أموال للاعب (إدارة فقط)',
            params = {
                id = { name = 'id', help = 'آيدي اللاعب' },
                moneytype = { name = 'moneytype', help = 'نوع المال (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'قيمة المال' },
            },
        },
        setmoney = {
            help = 'تعيين المبلغ المالي للاعب (إدارة فقط)',
            params = {
                id = { name = 'id', help = 'آيدي اللاعب' },
                moneytype = { name = 'moneytype', help = 'نوع المال (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'قيمة المال' },
            },
        },
        job = { help = 'التحقق من الوظيفة' },
        setjob = {
            help = 'اعطاء وظيفة للاعب (إدارة فقط)',
            params = {
                id = { name = 'id', help = 'ايدي اللاعب' },
                job = { name = 'job', help = 'اسم الوظيفة' },
                grade = { name = 'grade', help = 'رتبة الوظيفة' },
            },
        },
        gang = { help = 'التحقق من العصابة' },
        setgang = {
            help = 'اعطاء عصابة للاعب (إدارة فقط)',
            params = {
                id = { name = 'id', help = 'ايدي اللاعب' },
                gang = { name = 'gang', help = 'اسم العصابة' },
                grade = { name = 'grade', help = 'رتبة العصابة' },
            },
        },
        ooc = { help = 'OOC رسائل خارج الرول بلاي' },
        me = {
            help = 'اظهار الرسائل',
            params = {
                message = { name = 'message', help = 'الرسالة' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

local Translations = {
    error = {
        not_online = 'بازیکن آنلاین نیست',
        wrong_format = 'فرمت نادرست',
        missing_args = 'همه اطلاعات وارد نشده است (x, y, z)',
        missing_args2 = 'باید همه فیلدهای لازم پر شوند!',
        no_access = 'شما به این دستور دسترسی ندارید',
        company_too_poor = 'کارفرمای شما پول کافی ندارد',
        item_not_exist = 'آیتم وجود ندارد',
        too_heavy = 'فضای کافی در کیف شما نیست',
        location_not_exist = 'مکان وجود ندارد',
        duplicate_license = 'لایسنس راکستار تکراری یافت شد',
        no_valid_license  = 'لایسنس راکستار معتبر یافت نشد',
        not_whitelisted = 'شما در این سرور لیست سفید نیستید',
        server_already_open = 'سرور قبلاً باز است',
        server_already_closed = 'سرور قبلاً بسته است',
        no_permission = 'شما اجازه این کار را ندارید...',
        no_waypoint = 'هیچ نقطه‌ای تنظیم نشده است.',
        tp_error = 'خطا در هنگام انتقال.',
    },
    success = {
        server_opened = 'سرور باز شد',
        server_closed = 'سرور بسته شد',
        teleported_waypoint = 'به نقطه مشخص شده منتقل شدید.',
    },
    info = {
        received_paycheck = 'شما حقوق خود را به مبلغ $%{value} دریافت کردید',
        job_info = 'شغل: %{value} | سطح: %{value2} | در حال کار: %{value3}',
        gang_info = 'گروه: %{value} | سطح: %{value2}',
        on_duty = 'شما اکنون در حال کار هستید!',
        off_duty = 'شما اکنون خارج از کار هستید!',
        checking_ban = 'سلام %s. در حال بررسی وضعیت ممنوعیت شما هستیم.',
        join_server = 'خوش آمدید %s به {نام سرور}.',
        checking_whitelisted = 'سلام %s. در حال بررسی وضعیت مجاز بودن شما هستیم.',
        exploit_banned = 'شما به دلیل تقلب ممنوع شده‌اید. برای اطلاعات بیشتر به دیسکورد ما مراجعه کنید: %{discord}',
        exploit_dropped = 'شما به دلیل تقلب از سرور خارج شدید',
    },
    command = {
        tp = {
            help = 'انتقال به بازیکن یا مختصات (فقط ادمین)',
            params = {
                x = { name = 'id/x', help = 'شناسه بازیکن یا مختصات X' },
                y = { name = 'y', help = 'مختصات Y' },
                z = { name = 'z', help = 'مختصات Z' },
            },
        },
        tpm = { help = 'انتقال به نقطه مشخص شده (فقط ادمین)' },
        togglepvp = { help = 'تغییر وضعیت پی وی پی (فقط ادمین)' },
        addpermission = {
            help = 'ادمینی به بازیکن',
            params = {
                id = { name = 'id', help = 'شناسه بازیکن' },
                permission = { name = 'permission', help = 'سطح ادمینی' },
            },
        },
        removepermission = {
            help = 'حذف ادمینی از بازیکن',
            params = {
                id = { name = 'id', help = 'شناسه بازیکن' },
                permission = { name = 'permission', help = 'سطح ادمینی' },
            },
        },
        openserver = { help = 'باز کردن سرور برای همه (فقط ادمین)' },
        closeserver = {
            help = 'بستن سرور برای کسانی که ادمینی ندارند (فقط ادمین)',
            params = {
                reason = { name = 'reason', help = 'دلیل بستن (اختیاری)' },
            },
        },
        car = {
            help = 'اسپاون کردن خودرو (فقط ادمین)',
            params = {
                model = { name = 'model', help = 'نام مدل خودرو' },
            },
        },
        dv = { help = 'حذف خودرو (فقط ادمین)' },
        givemoney = {
            help = 'دادن پول به بازیکن (فقط ادمین)',
            params = {
                id = { name = 'id', help = 'شناسه بازیکن' },
                moneytype = { name = 'moneytype', help = 'نوع پول (نقدی، بانکی، کریپتو)' },
                amount = { name = 'amount', help = 'مقدار پول' },
            },
        },
        setmoney = {
            help = 'تنظیم مقدار پول بازیکن (فقط ادمین)',
            params = {
                id = { name = 'id', help = 'شناسه بازیکن' },
                moneytype = { name = 'moneytype', help = 'نوع پول (نقدی، بانکی، کریپتو)' },
                amount = { name = 'amount', help = 'مقدار پول' },
            },
        },
        job = { help = 'بررسی شغل' },
        setjob = {
            help = 'تنظیم شغل بازیکن (فقط ادمین)',
            params = {
                id = { name = 'id', help = 'شناسه بازیکن' },
                job = { name = 'job', help = 'نام شغل' },
                grade = { name = 'grade', help = 'سطح شغل' },
            },
        },
        gang = { help = 'بررسی گنگ' },
        setgang = {
            help = 'تنظیم گنگ بازیکن (فقط ادمین)',
            params = {
                id = { name = 'id', help = 'شناسه بازیکن' },
                gang = { name = 'gang', help = 'نام گنگ' },
                grade = { name = 'grade', help = 'سطح گنگ' },
            },
        },
        ooc = { help = 'پیام خارج از آر پی' },
        me = {
            help = 'ارسال پیام محلی',
            params = {
                message = { name = 'message', help = 'پیام' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'fa' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

local Translations = {
    error = {
        not_online = 'שחקן לא מחובר',
        wrong_format = 'פורמט שגוי',
        missing_args = '(x, y, z) לא כל פרמטר הוזן',
        missing_args2 = '!יש להזין את כל הפרמטרים',
        no_access = 'אין גישה לפקודה זו',
        company_too_poor = 'המעסיק שלך עני מידי',
        item_not_exist = 'פריט לא קיים',
        too_heavy = 'אינבנטורי מלא',
        location_not_exist = 'מקום לא קיים',
        duplicate_license = 'Rockstar נמצא שכפול רישיון',
        no_valid_license = 'תקף Rockstar לא נמצא רישיון',
        not_whitelisted = 'את/ה לא ברשימת המותרים בשרת הזה',
        server_already_open = 'השרת כבר פתוח',
        server_already_closed = 'השרת כבר סגור',
        no_permission = 'אין לך גישה לזה',
        no_waypoint = 'נקודת המיקום לא הוגדרה',
        tp_error = 'התרחשה שגיאה במהלך טלפורטציה',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {
        server_opened = 'השרת נפתח',
        server_closed = 'השרת נסגר',
        teleported_waypoint = 'נשלחת בטלפורטציה לנקודת המיקום',
    },
    info = {
        received_paycheck = '$%{value} קיבלת תלוש שכר על סך',
        job_info = '%{value3} :בתפקיד | %{value2} :דרגה | %{value} :עבודה',
        gang_info = '%{value2} :דרגה | %{value} :גאנג',
        on_duty = '!עלית לתפקיד',
        off_duty = '!ירדת מהתפקיד',
        join_server = '.{Server Name}-ל %s ברוך/ה הבא/ה',
        checking_ban = 'Checking banned status... 🔨',
        checking_whitelisted = 'Checking whitelist status... 👑',
        checking_license_credentials = 'Checking license credentials... 📖',
        checking_license_duplicate = 'Checking for duplicate license... ⛓️',
        exploit_banned = '%{discord} :נחסמת מהשרת על רמאות. למידע נוסף, הצטרף/י לשרת הדיסקורד שלנו',
        exploit_dropped = 'הועפת מהשרת על רמאות',
        password_header_normal = 'Input server password to join',
        password_header_maintenance = 'Server is currently under maitenance. Input Password to join.',
        password_prompt = 'Enter Password',
        password_submit = 'Submit',
        enter_maintenance_mode = "Entering Server Maintenance Mode",
    },
    command = {
        tp = {
            help = '(אדמינים בלבד) טלפורט לשחקן או לקואורדינטות',
            params = {
                x = { name = 'id/x', help = 'X של שחקן או קואורדינטת ID' },
                y = { name = 'y', help = 'Y קואורדינטת' },
                z = { name = 'z', help = 'Z קואורדינטת' },
            },
        },
        tpm = { help = 'טלפורט לנקודת מיקום (אדמינים בלבד)' },
        togglepvp = { help = '(אדמינים בלבד) בשרת PVP להפעיל/לכבות' },
        addpermission = {
            help = '(גוד בלבד) להביא גישה לשחקן',
            params = {
                id = { name = 'id', help = 'של שחקן ID' },
                permission = { name = 'גישה', help = 'רמת הגישה' },
            },
        },
        removepermission = {
            help = '(גוד בלבד) להסיר גישה לשחקן',
            params = {
                id = { name = 'id', help = 'של שחקן ID' },
                permission = { name = 'גישה', help = 'רמת הגישה' },
            },
        },
        openserver = { help = 'פתח את השרת לכולם (אדמינים בלבד)' },
        closeserver = {
            help = 'סגור את השרת לשחקנים ללא גישות (אדמינים בלבד)',
            params = {
                reason = { name = 'סיבה', help = 'הסיבה לסגירה (אופציונלי)' },
            },
        },
        car = {
            help = 'תיצור רכב (אדמינים בלבד)',
            params = {
                model = { name = 'דגם', help = 'שם הדגם של הרכב' },
            },
        },
        dv = { help = 'מחק רכב (אדמינים בלבד)' },
        givemoney = {
            help = 'תן כסף לשחקן (אדמינים בלבד)',
            params = {
                id = { name = 'id', help = 'של שחקן ID' },
                moneytype = { name = 'סוג כסף', help = '(cash, bank, crypto) סוג הכסף' },
                amount = { name = 'כמות', help = 'כמות הכסף' },
            },
        },
        setmoney = {
            help = 'קבע סכום כסף לשחקן (אדמינים בלבד)',
            params = {
                id = { name = 'id', help = 'של שחקן ID' },
                moneytype = { name = 'סוג כסף', help = '(cash, bank, crypto) סוג הכסף' },
                amount = { name = 'כמות', help = 'כמות הכסף' },
            },
        },
        job = { help = 'בדוק את העבודה שלך' },
        setjob = {
            help = 'קבע עבודה לשחקן (אדמינים בלבד)',
            params = {
                id = { name = 'id', help = 'של שחקן ID' },
                job = { name = 'עבודה', help = 'שם העבודה' },
                grade = { name = 'דרגה', help = 'דרגת העבודה' },
            },
        },
        gang = { help = 'בדוק את הגאנג שלך' },
        setgang = {
            help = 'קבע גאנג לשחקן (אדמינים בלבד)',
            params = {
                id = { name = 'id', help = 'של שחקן ID' },
                gang = { name = 'גאנג', help = 'שם הגאנג' },
                grade = { name = 'דרגה', help = 'דרגת הגאנג' },
            },
        },
        ooc = { help = 'OOC הודעת' },
        me = {
            help = 'הצג הודעה מקומית',
            params = {
                message = { name = 'הודעה', help = 'ההודעה שתישלח' }
            },
        },
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

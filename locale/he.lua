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
        duplicate_license = 'Rockstar נמצא שכפול רישיון',
        no_valid_license = 'תקף Rockstar לא נמצא רישיון',
        not_whitelisted = 'את/ה לא ברשימת המותרים בשרת הזה'
    },
    success = {},
    info = {
        received_paycheck = '$%{value} קיבלת תלוש שכר על סך',
        job_info = '%{value3} :בתפקיד | %{value2} :דרגה | %{value} :עבודה',
        gang_info = '%{value2} :דרגה | %{value} :גאנג',
        on_duty = '!עלית לתפקיד',
        off_duty = '!ירדת מהתפקיד',
        checking_ban = '.אנחנו בודקים אם את/ה חסום/ה בשרת הזה .%s שלום',
        join_server = '.{Server Name}-ל %s ברוך/ה הבא/ה',
        checking_whitelisted = '.אנחנו בודקים אם את/ה ברשימת המותרים .%s שלום'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

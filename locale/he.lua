local Translations = {
    error = {
        not_online = 'שחקן לא מחובר',
        wrong_format = 'פורמט שגוי',
        missing_args = 'יש לכתוב את הפקודה לפי מה שכתוב (x, y, z)',
        missing_args2 = 'יש למלא את כל המידע המבוקש',
        no_access = 'אין לך גישה לפקודה זו',
        company_too_poor = 'העסק שלך שבור',
        item_not_exist = 'אייטם לא נמצא',
        too_heavy = 'אינבנטורי מלא'
    },
    success = {},
    info = {
        received_paycheck = '$%{value} קיבלת משבורת על סך',
        job_info = '%{value3} :בתפקיד | %{value2} :דרגה | %{value} :עבודה',
        gang_info = '%{value2} :דרגה | %{value} :גאנג',
        on_duty = 'אתה בתפקיד כעת',
        off_duty = 'ירדת מתפקיד כעת'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

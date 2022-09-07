local Translations = {
    error = {
        not_online = 'Играчът не е онлайн',
        wrong_format = 'Некоректен формат',
        missing_args = 'Не всички аргументи са въведени (x, y, z)',
        missing_args2 = 'Всички аргументи трябва да бъдат попълнени!',
        no_access = 'Нямате достъп до тази команда',
        company_too_poor = 'Работодателят ви е разорен',
        item_not_exist = 'Артикулът не съществува',
        too_heavy = 'Ивентарът е препълнен',
        duplicate_license = 'Намерен е дубликат на Rockstar лиценза',
        no_valid_license  = 'Не е намерен валиден Rockstar лиценз',
        not_whitelisted = 'Вие не сте включени в белия списък за този сървър'
    },
    success = {},
    info = {
        received_paycheck = 'Получихте заплата от $%{value}',
        job_info = 'Работно място: %{value} | Чин: %{value2} | Служба: %{value3}',
        gang_info = 'Банда: %{value} | Чин: %{value2}',
        on_duty = 'Сега сте на служба!',
        off_duty = 'Вече не сте на служба!',
        checking_ban = 'Здравейте %s. Проверяваме дали сте баннат.',
        join_server = 'Добре дошли %s в {Server Name}.',
        checking_whitelisted = 'Здравейте %s. Проверяваме дали сте включени в белия списък.'
    }
}

if GetConvar('qb_locale', 'en') == 'bg' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

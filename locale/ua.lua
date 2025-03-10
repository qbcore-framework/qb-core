local Translations = {
    error = {
        not_online                  = 'Гравець не в мережі',
        wrong_format                = 'Невірний формат',
        missing_args                = 'Не введені всі аргументи (x, y, z)',
        missing_args2               = 'Усі аргументи повинні бути заповнені!',
        no_access                   = 'Немає доступу до цієї команди',
        company_too_poor            = 'Ваш роботодавець банкрут',
        item_not_exist              = 'Предмет не існує',
        too_heavy                   = 'Інвентар переповнено',
        location_not_exist          = 'Локація не існує',
        duplicate_license           = '[QBCORE] - Знайдено дубльовану ліцензію Rockstar',
        no_valid_license            = '[QBCORE] - Не знайдено дійсної ліцензії Rockstar',
        not_whitelisted             = '[QBCORE] - Ви не у білому списку цього сервера',
        server_already_open         = 'Сервер вже відкритий',
        server_already_closed       = 'Сервер вже закритий',
        no_permission               = 'У вас немає дозволу на це..',
        no_waypoint                 = 'Маршрут не встановлений.',
        tp_error                    = 'Помилка при телепортації.',
        ban_table_not_found         = '[QBCORE] - Не вдалося знайти таблицю банів у базі даних. Переконайтеся, що SQL файл імпортовано правильно.',
        connecting_database_error   = '[QBCORE] - Сталася помилка при підключенні до бази даних. Переконайтеся, що SQL сервер працює і дані в файлі server.cfg вірні.',
        connecting_database_timeout = '[QBCORE] - Підключення до бази даних вичерпало час. Переконайтеся, що SQL сервер працює і дані в файлі server.cfg вірні.',
    },
    success = {
        server_opened = 'Сервер відкрито',
        server_closed = 'Сервер закрито',
        teleported_waypoint = 'Телепортовано до маршруту.',
    },
    info = {
        received_paycheck = 'Ви отримали зарплату у розмірі $%{value}',
        job_info = 'Робота: %{value} | Клас: %{value2} | Чергування: %{value3}',
        gang_info = 'Банда: %{value} | Клас: %{value2}',
        on_duty = 'Ви на чергуванні!',
        off_duty = 'Ви не на чергуванням!',
        checking_ban = 'Привіт %s. Ми перевіряємо, чи ви забанені.',
        join_server = 'Ласкаво просимо %s на {Server Name}.',
        checking_whitelisted = 'Привіт %s. Ми перевіряємо ваш дозвіл.',
        exploit_banned = 'Ви забанені за шахрайство. Перевірте наш Discord для додаткової інформації: %{discord}',
        exploit_dropped = 'Ви були вигнані за експлуатацію',
    },
    command = {
        tp = {
            help = 'Телепортуватися до гравця або координат (тільки адміністратори)',
            params = {
                x = { name = 'id/x', help = 'ID гравця або X координата' },
                y = { name = 'y', help = 'Y координата' },
                z = { name = 'z', help = 'Z координата' },
            },
        },
        tpm = { help = 'Телепортуватися до маркера (тільки адміністратори)' },
        togglepvp = { help = 'Включити/вимкнути PVP на сервері (тільки адміністратори)' },
        addpermission = {
            help = 'Надати гравцю дозволи (тільки Бог)',
            params = {
                id = { name = 'id', help = 'ID гравця' },
                permission = { name = 'permission', help = 'Рівень дозволу' },
            },
        },
        removepermission = {
            help = 'Видалити дозволи у гравця (тільки Бог)',
            params = {
                id = { name = 'id', help = 'ID гравця' },
                permission = { name = 'permission', help = 'Рівень дозволу' },
            },
        },
        openserver = { help = 'Відкрити сервер для всіх (тільки адміністратори)' },
        closeserver = {
            help = 'Закрити сервер для людей без дозволів (тільки адміністратори)',
            params = {
                reason = { name = 'reason', help = 'Причина закриття (необов\'язково)' },
            },
        },
        car = {
            help = 'Спавнити транспорт (тільки адміністратори)',
            params = {
                model = { name = 'model', help = 'Назва моделі транспортного засобу' },
            },
        },
        dv = { help = 'Видалити транспорт (тільки адміністратори)' },
        dvall = { help = 'Видалити всі транспортні засоби (тільки адміністратори)' },
        dvp = { help = 'Видалити всіх NPC (тільки адміністратори)' },
        dvo = { help = 'Видалити всі об\'єкти (тільки адміністратори)' },
        givemoney = {
            help = 'Дати гроші гравцю (тільки адміністратори)',
            params = {
                id = { name = 'id', help = 'ID гравця' },
                moneytype = { name = 'moneytype', help = 'Тип грошей (готівка, банк, криптовалюта)' },
                amount = { name = 'amount', help = 'Сума грошей' },
            },
        },
        setmoney = {
            help = 'Встановити кількість грошей у гравця (тільки адміністратори)',
            params = {
                id = { name = 'id', help = 'ID гравця' },
                moneytype = { name = 'moneytype', help = 'Тип грошей (готівка, банк, криптовалюта)' },
                amount = { name = 'amount', help = 'Сума грошей' },
            },
        },
        job = { help = 'Перевірити вашу роботу' },
        setjob = {
            help = 'Встановити роботу гравця (тільки адміністратори)',
            params = {
                id = { name = 'id', help = 'ID гравця' },
                job = { name = 'job', help = 'Назва роботи' },
                grade = { name = 'grade', help = 'Клас роботи' },
            },
        },
        gang = { help = 'Перевірити вашу банду' },
        setgang = {
            help = 'Встановити банду гравця (тільки адміністратори)',
            params = {
                id = { name = 'id', help = 'ID гравця' },
                gang = { name = 'gang', help = 'Назва банди' },
                grade = { name = 'grade', help = 'Клас банди' },
            },
        },
        ooc = { help = 'Повідомлення у OOC чаті' },
        me = {
            help = 'Показати локальне повідомлення',
            params = {
                message = { name = 'message', help = 'Повідомлення для відправлення' }
            },
        },
    },
}
if GetConvar('qb_locale', 'en') == 'ua' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end

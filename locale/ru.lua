local Translations = {
    error = {
        not_online = 'Игрок не в сети',
        wrong_format = 'Неверный формат',
        missing_args = 'Не все аргументы были заполнены (x, y, z)',
        missing_args2 = 'Все аргументы должны быть заполнены!',
        no_access = 'Нет доступа к этой команде',
        company_too_poor = 'Ваш работодатель без денег',
        item_not_exist = 'Вещь не существует',
        too_heavy = 'Инвентарь слишком полный',
        location_not_exist = 'Локация не существует',
        duplicate_license = 'Найден дубликат лицензии Rockstar',
        no_valid_license = 'Не найдена действующая лицензия Rockstar',
        not_whitelisted = 'Вы не в белом списке этого сервера',
        server_already_open = 'Этот сервер уже открыт',
        server_already_closed = 'Этот сервер уже закрыт',
        no_permission = 'У вас нет к этому доступа',
        no_waypoint = 'Путевая точка не настроена',
        tp_error = 'Произошла ошибка во время телепортации',
    },
    success = {
        server_opened = 'Сервер открыт',
        server_closed = 'Сервер закрыт',
        teleported_waypoint = 'Вы были телепортированы к путевой точке',
    },
    info = {
        received_paycheck = 'Вы получили зарплату в размере $%{value}',
        job_info = 'Задание: %{value} | Оценка: %{value2} | Дежурство: %{value3}',
        gang_info = 'Банда: %{value} | Оценка: %{value2}',
        on_duty = 'Вы сейчас на дежурстве!',
        off_duty = 'Вы сейчас не дежурный!',
        checking_ban = 'Привет %s. Мы проверяем если вы забанены.',
        join_server = 'Добро пожаловать %s в {Server Name}.',
        checking_whitelisted = 'Привет %s. Мы проверяем если вы в белом списке.',
        exploit_banned = 'Вы были забанены за мошенничество. Чтобы узнать больше, присоединяйтесь к нашему серверу Discord: %{discord}',
        exploit_dropped = 'Вас выгнали с сервера за мошенничество',
    },
    command = {
        tp = {
            help = 'Телепортироваться к игроку или координатам (только админам)',
            params = {
                x = { name = 'id/x', help = 'ID игрока или координат X' },
                y = { name = 'y', help = 'Координат Y' },
                z = { name = 'z', help = 'Координат Z' },
            },
        },
        tpm = { help = 'Телепортироваться к путевой точке (только админам)' },
        togglepvp = { help = 'Включить/отключить PVP на сервере (только админам)' },
        addpermission = {
            help = 'Дать доступ игроку (только god)',
            params = {
                id = { name = 'id', help = 'ID игрока' },
                permission = { name = 'доступ', help = 'Уровень доступа' },
            },
        },
        removepermission = {
            help = 'Убрать доступ от игрока (только god)',
            params = {
                id = { name = 'id', help = 'ID игрока' },
                permission = { name = 'доступ', help = 'Уровень доступа' },
            },
        },
        openserver = { help = 'Открыть сервер всем (только админам)' },
        closeserver = {
            help = 'Закрыть сервер для игроков без доступа (только админам)',
            params = {
                reason = { name = 'причина', help = 'Причина закрытия (необязательно)' },
            },
        },
        car = {
            help = 'Создать транспорт (только админам)',
            params = {
                model = { name = 'модель', help = 'Название модели транспорта' },
            },
        },
        dv = { help = 'Удалить транспорт (только админам)' },
        givemoney = {
            help = 'Дать деньги игроку (только админам)',
            params = {
                id = { name = 'id', help = 'ID игрока' },
                moneytype = { name = 'вид денег', help = 'Вид денег (cash, bank, crypto)' },
                amount = { name = 'количество', help = 'Количество денег' },
            },
        },
        setmoney = {
            help = 'Настроить сумму денег игрока (только админам)',
            params = {
                id = { name = 'id', help = 'ID игрока' },
                moneytype = { name = 'вид денег', help = 'Вид денег (cash, bank, crypto)' },
                amount = { name = 'количество', help = 'Количество денег' },
            },
        },
        job = { help = 'Проверьте свою работу' },
        setjob = {
            help = 'Настроить работу игрока (только админам)',
            params = {
                id = { name = 'id', help = 'ID игрока' },
                job = { name = 'работа', help = 'Название работы' },
                grade = { name = 'ранг', help = 'Ранг работы' },
            },
        },
        gang = { help = 'Проверьте свою банду' },
        setgang = {
            help = 'Настроить банду игрока (только админам)',
            params = {
                id = { name = 'id', help = 'ID игрока' },
                gang = { name = 'банда', help = 'Название банды' },
                grade = { name = 'ранг', help = 'Ранг банды' },
            },
        },
        ooc = { help = 'Сообщение ООС в чате' },
        me = {
            help = 'Показать локальное сообщение',
            params = {
                message = { name = 'сообщение', help = 'Сообщение для отправки' },
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'ru' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

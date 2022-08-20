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
        server_already_closed = 'Этот сервер уже закрыт'
    },
    success = {
        server_opened = 'Сервер открыт',
        server_closed = 'Сервер закрыт'
    },
    info = {
        received_paycheck = 'Вы получили зарплату в размере $%{value}',
        job_info = 'Задание: %{value} | Оценка: %{value2} | Дежурство: %{value3}',
        gang_info = 'Банда: %{value} | Оценка: %{value2}',
        on_duty = 'Вы сейчас на дежурстве!',
        off_duty = 'Вы сейчас не дежурный!',
        checking_ban = 'Привет %s. Мы проверяем если вы забанены.',
        join_server = 'Добро пожаловать %s в {Server Name}.',
        checking_whitelisted = 'Привет %s. Мы проверяем если вы в белом списке.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
    error = {
        not_online = 'Игрок не в сети',
        wrong_format = 'Неверный формат',
        missing_args = 'Введены не все аргументы (x, y, z)',
        missing_args2 = 'Все аргументы должны быть заполнены!',
        no_access = 'Нет доступа к этой команде',
        company_too_poor = 'Ваш работодатель разорился',
        item_not_exist = 'Элемент не существует',
        too_heavy = 'Инвентарь слишком полон'
    },
    success = {},
    info = {
        received_paycheck = 'Вы получили зарплату в размере $%{value}',
        job_info = 'Задание: %{значение} | Оценка: %{value2} | Обязанность: %{value3}',
        gang_info = 'Банда: %{значение} | Оценка: %{value2}',
        on_duty = 'Вы сейчас на дежурстве!',
        off_duty = 'Вы сейчас не дежурный!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

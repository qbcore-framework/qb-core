local Translations = {
    error = {
        not_online = 'El jugador no está en línea',
        wrong_format = 'Formato incorrecto',
        missing_args = 'No se han ingresado todos los argumentos (x, y, z)',
        missing_args2 = '¡Todos los argumentos deben estar presentes!',
        no_access = 'No tienes acceso a este comando',
        company_too_poor = 'Tu empleador está en bancarrota',
        item_not_exist = 'El objeto no existe',
        too_heavy = 'Inventario muy lleno',
        duplicate_license = 'Tu licencia de Rockstar está duplicada',
        no_valid_license  = 'No tienes licencia de Rockstar válida',
        not_whitelisted = 'No estás en la lista blanca de este servidor'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu salario de $%{value}',
        job_info = 'Trabajo: %{value} | Puesto: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Puesto: %{value2}',
        on_duty = 'Estás en servicio',
        off_duty = 'Estás fuera de servicio',
        checking_ban = 'Hola %s. Estamos revisando si has sido baneado.',
        join_server = 'Bienvenido %s a {Server Name}.',
        checking_whitelisted = 'Hola %s. Estamos revisando si estás en nuestra lista blanca.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

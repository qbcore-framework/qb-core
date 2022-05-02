local Translations = {
    error = {
        not_online = '¡El jugador no está conectado!',
        wrong_format = '¡Formato incorrecto!',
        missing_args = '¡No todos los argumentos están presentes! (x, y, z)',
        missing_args2 = '¡Todos los argumentos tienen que estar presentes!',
        no_access = '¡No tienes acceso a este comando!',
        company_too_poor = 'Tu empresa está en bancarrota. No hay dinero suficiente.',
        item_not_exist = 'El objeto no existe en el sistema.',
        too_heavy = 'Tienes el inventario muy lleno.',
        duplicate_license = 'Tu licencia de Rockstar está duplicada',
        no_valid_license  = 'No tienes licencia de Rockstar válida',
        not_whitelisted = 'No estás en la lista blanca de este servidor'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu pago de $%{value}',
        job_info = 'Trabajo: %{value} | Grado: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Grado: %{value2}',
        on_duty = '¡Ahora estás en servicio!',
        off_duty = '¡Ahora estás fuera de servicio!',
        checking_ban = 'Hola %s. Estámos revisando si has sido baneado.',
        join_server = 'Bienvenido %s a {Server Name}.',
        checking_whitelisted = 'Hola %s. Estámos revisando si estás en lista blanca.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

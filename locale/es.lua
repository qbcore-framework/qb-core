local Translations = {
    error = {
        not_online = 'El jugador no está conectado',
        wrong_format = 'Formato incorrecto',
        missing_args = 'No se han ingresado todos los argumentos (x, y, z)',
        missing_args2 = '¡Debes ingresar todos los argumentos!',
        no_access = 'No tienes acceso a este comando',
        company_too_poor = 'Tu empleador está en bancarrota',
        item_not_exist = 'El objeto no existe',
        too_heavy = 'No hay espacio en tu inventario',
        duplicate_license = 'Licencia de Rockstar duplicada',
        no_valid_license  = 'No tienes una licencia de Rockstar válida',
        not_whitelisted = 'No tienes acceso a este servidor',
        server_already_open = 'El servidor ya está abierto',
        server_already_closed = 'El servidor ya está cerrado'
    },
    success = {
        server_opened = 'El servidor ha sido abierto',
        server_closed = 'El servidor ha sido cerrado'
    },
    info = {
        received_paycheck = 'Has recibido tu salario de $%{value}',
        job_info = 'Trabajo: %{value} | Puesto: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Puesto: %{value2}',
        on_duty = '¡Estás en servicio!',
        off_duty = '¡Estás fuera de servicio!',
        checking_ban = 'Hola %s. Estamos revisando la lista de baneos.',
        join_server = 'Bienvenid@ a {Server Name}, %s.',
        checking_whitelisted = 'Hola %s. Estamos revisando si tienes acceso a nuestro servidor.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

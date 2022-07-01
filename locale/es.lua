local Translations = {
    error = {
        not_online = 'El jugador no está conectado',
        wrong_format = 'Formato incorrecto',
        missing_args = 'No se han introducido todos los argumentos (x, y, z)',
        missing_args2 = 'Debes introducir todos los argumentos',
        no_access = 'No tienes acceso a este comando',
        company_too_poor = 'Tu empresa está en bancarrota',
        item_not_exist = 'El objeto no existe',
        too_heavy = 'No tienes espacio en tu inventario',
        duplicate_license = 'Licencia de Rockstar está duplicada',
        no_valid_license  = 'No tienes una licencia de Rockstar válida',
        not_whitelisted = 'No tienes acceso a este servidor'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu salario de %{value}$',
        job_info = 'Trabajo: %{value} | Puesto: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Puesto: %{value2}',
        on_duty = 'Estás de servicio',
        off_duty = 'Estás fuera de servicio',
        checking_ban = 'Bienvenid@ %s. Estamos revisando la lista de baneos.',
        join_server = 'Bienvenid@ a {Server Name}, %s.',
        checking_whitelisted = 'Hola %s. Estamos revisando si tienes acceso a nuestro servidor.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

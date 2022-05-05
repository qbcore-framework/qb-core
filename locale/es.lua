local Translations = {
    error = {
        not_online = 'El jugador no está en línea',
        wrong_format = 'Formato incorrecto',
        missing_args = 'No se han ingresado todos los argumentos (x, y, z)',
        missing_args2 = '¡Todos los argumentos deben estar presentes!',
        no_access = 'No tienes acceso a este comando',
        company_too_poor = 'Tu empleador está en bancarrota',
        item_not_exist = 'El objeto no existe',
        too_heavy = 'Tienes el inventario muy lleno'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu salario de $%{value}',
        job_info = 'Trabajo: %{value} | Puesto: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Puesto: %{value2}',
        on_duty = '¡Ahora estás en servicio!',
        off_duty = '¡Ahora estás fuera de servicio!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

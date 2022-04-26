local Translations = {
    error = {
        not_online = 'El jugador no está conectado!',
        wrong_format = 'Formato incorrecto!',
        missing_args = 'No todos los argumentos estan presente! (x, y, z)',
        missing_args2 = 'Todos los argumentos tienen que estar presente!',
        no_access = 'No tienes acceso a este comando!',
        company_too_poor = 'Tu empresa está en bancarrota. No hay dinero suficiente.',
        item_not_exist = 'El objeto no existe en el sistema.',
        too_heavy = 'Tienes el inventario muy lleno.',
        duplicate_license = 'Aun estas dentro.',
        no_valid_license  = 'No es valida tu licencia de GTA',
        not_whitelisted = 'No tienes acceso a este server. para mas info: https://discord.gg/rNJgAn5v2T'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu pago de $%{value}',
        job_info = 'Trabajo: %{value} | Grado: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Grado: %{value2}',
        on_duty = 'Ahora estás en servicio!',
        off_duty = 'Ahora estás fuera de servicio!',
        checking_ban = 'Hola %s. Estamos comprobando que no estas baneado.',
        join_server = 'Bienvenido %s a {Server Name}.',
        checking_whitelisted = 'Hola %s. Estamos revisando su acceso al servidor...'

    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

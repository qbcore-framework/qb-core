local Translations = {
    error = {
        not_online = 'El jugador no esta conectado!',
        wrong_format = 'Formato incorrecto!',
        missing_args = 'No todos los argumentos estan presente! (x, y, z)',
        missing_args2 = 'Todos los argumentos estan presente!',
        no_access = 'No tienes acceso a este comando!',
        company_too_poor = 'Tu empresa está en bancarrota. No hay dinero suficiente.',
        item_not_exist = 'El objeto no existe en el systema.',
        too_heavy = 'Tienes el inventario muy lleno.'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu pago de $%{value}',
        job_info = 'Trabajo: %{value} | Grado: %{value2} | Estado: %{value3}',
        gang_info = 'Banda: %{value} | Grado: %{value2}',
        on_duty = 'Ahora estás en servicio!',
        off_duty = 'Ahora estás fuera de servicio!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

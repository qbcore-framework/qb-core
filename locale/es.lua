local Translations = {
    error = {
        not_online = 'Jugador no conectado',
        wrong_format = 'Formato incorrecto',
        missing_args = 'No todos los argumentos han sido rellenados (x, y, z)',
        missing_args2 = 'Todos los argumentos deben ser rellenados!',
        no_access = 'No tienes acceso a este comando',
        company_too_poor = 'Tu empresa está en bancarrota',
        item_not_exist = 'El objeto no existe',
        too_heavy = 'Tienes el inventario lleno'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu paga de $%{value}',
        job_info = 'Trabajo: %{value} | Rango: %{value2} | Estado: %{value3}',
        gang_info = 'Banda: %{value} | Rango: %{value2}',
        on_duty = 'Ahora estás de servicio!',
        off_duty = 'Ahora estás fuera de servicio!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
    error = {
        not_online = 'El jugador no está conectado!',
        wrong_format = 'Formato incorrecto!',
        missing_args = 'No todos los argumentos estan presente! (x, y, z)',
        missing_args2 = 'Todos los argumentos tienen que estar presente!',
        missing_args = 'No todos los argumentos estan presentes! (x, y, z)',
        missing_args2 = 'Todos los argumentos deben estar presentes!',
        no_access = 'No tienes acceso a este comando!',
        company_too_poor = 'Tu empresa está en bancarrota. No hay dinero suficiente.',
        item_not_exist = 'El objeto no existe en el sistema.',
        too_heavy = 'Tienes el inventario muy lleno.'
    },
    success = {},
    info = {
        received_paycheck = 'Has recibido tu pago de $%{value}',
        job_info = 'Trabajo: %{value} | Grado: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Grado: %{value2}',
        on_duty = 'Ahora estás en servicio!',
        off_duty = 'Ahora estás fuera de servicio!'
    }
}

--if not Lang then            --This test is only needed in locale en, please comment it on other languages

    local templocale = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        locale = "es"
    }) 
    if templocale then
        Lang = templocale
    end
    
--end                         --Comment this line also
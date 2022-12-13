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
        location_not_exist = 'La ubicación no existe',
        duplicate_license = 'Licencia de Rockstar duplicada',
        no_valid_license  = 'No tienes una licencia de Rockstar válida',
        not_whitelisted = 'No tienes acceso a este servidor',
        server_already_open = 'El servidor ya está abierto',
        server_already_closed = 'El servidor ya está cerrado',
        no_permission = 'No tienes permisos para esto..',
        no_waypoint = 'No hay waypoint establecido.',
        tp_error = 'Error mientras se teletransporta.',
    },
    success = {
        server_opened = 'El servidor ha sido abierto',
        server_closed = 'El servidor ha sido cerrado',
        teleported_waypoint = 'Teletransportado a punto de encuentro.',
    },
    info = {
        received_paycheck = 'Has recibido tu salario de $%{value}',
        job_info = 'Trabajo: %{value} | Puesto: %{value2} | Estado: %{value3}',
        gang_info = 'Pandilla: %{value} | Puesto: %{value2}',
        on_duty = '¡Estás en servicio!',
        off_duty = '¡Estás fuera de servicio!',
        checking_ban = 'Hola %s. Estamos revisando la lista de baneos.',
        join_server = 'Bienvenid@ a {Server Name}, %s.',
        checking_whitelisted = 'Hola %s. Estamos revisando si tienes acceso a nuestro servidor.',
        exploit_banned = 'Has sido expulsado por hacer trampas. Consulta nuestro Discord para más información: %{discord}',
        exploit_dropped = 'Has sido expulsado por hacer trampas',
    },
    command = {
        tp = {
            help = 'TP al jugador o a las coordenadas (sólo para admin)',
            params = {
                x = { name = 'id/x', help = 'ID de jugador o posición X'},
                y = { name = 'y', help = 'Y posición'},
                z = { name = 'z', help = 'Z posición'},
            },
        },
        tpm = { help = 'TP al marcador (sólo para admin)' },
        togglepvp = { help = 'Activar el PVP en el servidor (sólo para admin)' },
        addpermission = {
            help = 'Dar permisos al jugador (sólo modo Dios)',
            params = {
                id = { name = 'id', help = 'ID del jugador' },
                permission = { name = 'permission', help = 'Nivel de permiso' },
            },
        },
        removepermission = {
            help = 'Eliminar los permisos de los jugadores (sólo modo Dios)',
            params = {
                id = { name = 'id', help = 'ID del jugador' },
                permission = { name = 'permission', help = 'Nivel de permiso' },
            },
        },
        openserver = { help = 'Abrir el servidor para todo el mundo (sólo para admin)' },
        closeserver = {
            help = 'Cerrar el servidor para personas sin permisos (sólo para admin)',
            params = {
                reason = { name = 'reason', help = 'Motivo del cierre (opcional)' },
            },
        },
        car = {
            help = 'Crear Vehículo (sólo para admin)',
            params = {
                model = { name = 'model', help = 'Nombre del modelo del vehículo' },
            },
        },
        dv = { help = 'Borrar vehículo (sólo para admin)' },
        givemoney = {
            help = 'Dar dinero a un jugador (sólo para admin)',
            params = {
                id = { name = 'id', help = 'ID del jugador' },
                moneytype = { name = 'moneytype', help = 'Tipo de dinero (efectivo, banco, cripto)' },
                amount = { name = 'amount', help = 'Cantidad de dinero' },
            },
        },
        setmoney = {
            help = 'Establecer la cantidad de dinero de los jugadores (sólo para admin)',
            params = {
                id = { name = 'id', help = 'ID del jugador' },
                moneytype = { name = 'moneytype', help = 'Tipo de dinero (efectivo, banco, cripto)' },
                amount = { name = 'amount', help = 'Cantidad de dinero' },
            },
        },
        job = { help = 'Compruebe su trabajo' },
        setjob = {
            help = 'Establecer un trabajo de jugador (sólo para admin)',
            params = {
                id = { name = 'id', help = 'ID del jugador' },
                job = { name = 'job', help = 'Nombre del trabajo' },
                grade = { name = 'grade', help = 'Grado de trabajo' },
            },
        },
        gang = { help = 'Comprueba tu banda' },
        setgang = {
            help = 'Establecer una banda de jugadores (sólo para admin)',
            params = {
                id = { name = 'id', help = 'ID del jugador' },
                gang = { name = 'gang', help = 'Nombre de la banda' },
                grade = { name = 'grade', help = 'Grado de banda' },
            },
        },
        ooc = { help = 'Mensaje del chat OOC' },
        me = {
            help = 'Mostrar mensaje local',
            params = {
                message = { name = 'message', help = 'Mensaje a enviar' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

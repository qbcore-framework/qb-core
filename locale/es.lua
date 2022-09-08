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
        server_already_closed = 'El servidor ya está cerrado',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
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
        join_server = 'Bienvenid@ a, %s.',
        checking_ban = 'Checking banned status... 🔨',
        checking_whitelisted = 'Checking whitelist status... 👑',
        checking_license_credentials = 'Checking license credentials... 📖',
        checking_license_duplicate = 'Checking for duplicate license... ⛓️',
        password_header_normal = 'Input server password to join',
        password_header_maintenance = 'Server is currently under maitenance. Input Password to join.',
        password_prompt = 'Enter Password',
        password_submit = 'Submit',
        enter_maintenance_mode = "Entering Server Maintenance Mode",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

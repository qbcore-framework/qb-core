local Translations = {
    error = {
        not_online = 'Player online nist !',
        wrong_format = 'Vorodi sahih nist !',
        missing_args = 'Vorodi naghes ast (x, y, z)',
        missing_args2 = 'Tamam vorodi hara vared konid !',
        no_access = 'Shoma dastresi nadarid !',
        company_too_poor = 'Sherkat shoma, pul kafi baraye hoghogh dadan nadarad !',
        item_not_exist = 'In item vojod nadarad',
        too_heavy = 'Inventory kheyli sangin ast !',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Hoghogh shoma variz shod : $%{value}',
        job_info = 'Shoghl: %{value} | Daraje: %{value2} | Dar hal kar: %{value3}',
        gang_info = 'Gang: %{value} | Daraje: %{value2}',
        on_duty = 'Shoma dar hal kar hastid (on-duty)!',
        off_duty = 'Shoma az kar kharej shodid (off-duty)!',
        password_header_normal = 'Input server password to join',
        password_header_maintenance = 'Server is currently under maitenance. Input Password to join.',
        password_prompt = 'Enter Password',
        password_submit = 'Submit',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

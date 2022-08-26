local Translations = {
    error = {
        not_online = 'Igrac nije online',
        wrong_format = 'Netacan format',
        missing_args = 'Nije unet svaki argument (x, y, z)',
        missing_args2 = 'Svi argumenti moraju biti popunjeni!',
        no_access = 'Nemate pristup ovoj komandi',
        company_too_poor = 'Vas poslodavac nema para',
        item_not_exist = 'Stavka ne postoji',
        too_heavy = 'Inventar je prepun',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Dobili ste platu u iznosu od $%{value}',
        job_info = 'Posao: %{value} | Rank: %{value2} | Duznost: %{value3}',
        gang_info = 'Banda: %{value} | Rank: %{value2}',
        on_duty = 'Sada ste na duznosti!',
        off_duty = 'Sada ste van duznosti!',
        password_error = "Error: Too many incorrect password attempts",
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

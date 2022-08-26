local Translations = {
    error = {
        not_online = 'Pelaaja ei ole paikalla',
        wrong_format = 'Virheellinen muoto',
        missing_args = 'Kaikkia argumentteja ei ole syötetty (x, y, z)',
        missing_args2 = 'Kaikkia argumentteja ei ole syötetty!',
        no_access = 'Sinulla ei ole oikeuksia kyseiseen komentoon',
        company_too_poor = 'Sinun firmasi on liian köyhä',
        item_not_exist = 'Tätä itemiä ei ole olemassa',
        too_heavy = 'Reppusi on liian täynnä',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Sinä sait palkan $%{value}',
        job_info = 'Työ: %{value} | Arvo: %{value2} | Vuorossa: %{value3}',
        gang_info = 'Jengi: %{value} | Arvo: %{value2}',
        on_duty = 'Sinä olet nyt vuorossa!',
        off_duty = 'Sinä poistuit vuorosta!',
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

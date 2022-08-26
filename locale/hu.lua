local Translations = {
    error = {
        not_online = 'A játékos nem elérhető',
        wrong_format = 'Helytelen formátum',
        missing_args = 'Nem minden érték lett megadva (x, y, z)',
        missing_args2 = 'Az összes értéket meg kell adnod!',
        no_access = 'Nem használhatod ezt a parancsot',
        company_too_poor = 'A munkáltatód nem tudott kifizetni',
        item_not_exist = 'Ez a tárgy nem létezik',
        too_heavy = 'A leltárad megtelt',
        server_currently_closed = 'Server is currently closed.',
        password_error = "Error: Too many incorrect password attempts",
        password_error_attempts = "Error: Invalid pasword entered (%{attempts} attempt(s) remaining!)",
    },
    success = {},
    info = {
        received_paycheck = 'Megérkezett a fizetésed: %{value}$',
        job_info = 'Munka: %{value} | Szint: %{value2} | Szolgálatban: %{value3}',
        gang_info = 'Banda: %{value} | Szint: %{value2}',
        on_duty = 'Mostantól szolgálatban vagy!',
        off_duty = 'Mostantól nem vagy szolgálatban!',
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
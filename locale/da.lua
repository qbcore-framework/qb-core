local Translations = {
    error = {
        not_online = 'Spiller ikke online',
        wrong_format = 'Forkert format',
        missing_args = 'Ikke alle argumenter er blevet indtastet (x, y, z)',
        missing_args2 = 'Alle argumenter skal udfyldes!',
        no_access = 'Ingen adgang til denne kommando',
        company_too_poor = 'Din arbejdsgiver er i stykker',
        item_not_exist = 'Ting findes',
        too_heavy = 'Dit Inventory er fuldt',
        duplicate_license = 'Duplikeret rockstar licens er fundet',
        no_valid_license  = 'Ingen gyldig Rockstar-licens fundet',
        not_whitelisted = 'Du er ikke allowlistet til at spille på denne server'
    },
    success = {},
    info = {
        received_paycheck = 'Du har modtaget din lønseddel på $%{value}',
        job_info = 'Arbejde: %{value} | Grad: %{value2} | Job: %{value3}',
        gang_info = 'Bande: %{value} | Grad: %{value2}',
        on_duty = 'Du er nu på arbejde, god arbejdslyst!',
        off_duty = 'Du er ikke længere på arbejde!'
        checking_ban = 'Hej %s. Vi ser om du er bannet på denne server.',
        join_server = 'Velkommen til %s til {Server Name}.',
        checking_whitelisted = 'Hej %s. Vi ser om du er allowlistet!.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

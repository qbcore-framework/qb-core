local Translations = {
    error = {
        not_online = 'Spiller ikke online',
        wrong_format = 'ugyldigt format',
        missing_args = 'Alle argumenter er ikke udfyldt (x, y, z)',
        missing_args2 = 'Alle argumenter skal være udfyldt!',
        no_access = 'Ingen adgang til denne command',
        company_too_poor = 'Arbejdsgiveren er for fattig',
        item_not_exist = 'Enheden eksistere ikke',
        too_heavy = 'Dit inventory er for fyldt'
    },
    success = {},
    info = {
        received_paycheck = 'Du modtog din lønseddel på %{value} DKK',
        job_info = 'Arbejde: %{value} | Grad: %{value2} | Job: %{value3}',
        gang_info = 'Bande: %{value} | Grad: %{value2}',
        on_duty = 'Du er nu på arbejde, god arbejdslyst!',
        off_duty = 'Du er ikke længere på arbejde!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

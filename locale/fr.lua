local Translations = {
    error = {
        not_online = 'Le joueur n\'est pas connecté',
        wrong_format = 'Format incorrect',
        missing_args = 'Arguments manquant (x, y, z)',
        missing_args2 = 'Tous les arguments doivent être remplis!',
        no_access = 'Vous n\'avez pas accès à cette commande',
        company_too_poor = 'Votre entreprise n\'a pas suffisamment d\'argent',
        item_not_exist = 'L\'objet n\'existe pas',
        too_heavy = 'L\'inventaire est plein',
        duplicate_license = 'License Rockstar Dupliquée trouvée',
        no_valid_license  = 'Aucune License Rockstar trouvée',
        not_whitelisted = "Vous n'êtes pas whitelist sur ce serveur"
    },
    success = {},
    info = {
        received_paycheck = 'Vous avez reçu votre salaire de : $%{value}',
        job_info = 'Emplois: %{value} | Grade: %{value2} | Service: %{value3}',
        gang_info = 'Gang: %{value} | Grade: %{value2}',
        on_duty = 'Vous êtes désormais en service!',
        off_duty = 'Vous n\'êtes plus en service!',
        checking_ban = 'Bonjour %s. Nous verifions si vous êtes banni.',
        validatin_license = 'bonjour %s. Nous validons votre License Rockstar.',
        join_server = 'Bienvenue %s sur {Server Name}.',
        checking_whitelisted = 'Bonjour %s. Nous vérifions si vous êtes Whitelist.'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 

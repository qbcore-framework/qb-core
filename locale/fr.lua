local Translations = {
    error = {
        not_online = 'Le joueur n\'est pas connecté',
        wrong_format = 'Format incorrect',
        missing_args = 'Arguments manquants (x, y, z)',
        missing_args2 = 'Tous les arguments doivent être remplis!',
        no_access = 'Vous n\'avez pas accès à cette commande',
        company_too_poor = 'Votre entreprise n\'a pas suffisamment d\'argent',
        item_not_exist = 'L\'objet n\'existe pas',
        too_heavy = 'L\'inventaire est plein',
        duplicate_license = 'License Rockstar Dupliquée trouvée',
        no_valid_license  = 'Aucune License Rockstar trouvée',
        not_whitelisted = 'Vous n\'êtes pas Whitelisté sur ce serveur',
        server_already_open = 'Le serveur est déjà ouvert',
        server_already_closed = 'Le serveur est déjà fermé'
    },
    success = {
        server_opened = 'Le serveur a été ouvert',
        server_closed = 'Le serveur a été fermé'
    },
    info = {
        received_paycheck = 'Vous avez reçu votre salaire de : $%{value}',
        job_info = 'Emplois: %{value} | Grade: %{value2} | Service: %{value3}',
        gang_info = 'Gang: %{value} | Grade: %{value2}',
        on_duty = 'Vous êtes désormais en service!',
        off_duty = 'Vous n\'êtes plus en service!',
        checking_ban = 'Bonjour %s. Nous verifions si vous êtes banni.',
        validatin_license = 'Bonjour %s. Nous validons votre License Rockstar.',
        join_server = 'Bienvenue %s sur {Server Name}.',
        checking_whitelisted = 'Bonjour %s. Nous vérifions si vous êtes sur la "whitelist".'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
error = {
        not_online = 'Giocatore Offline',
        wrong_format = 'Formato sbagliato',
        missing_args = 'Devi inserire ancora qualcosa(x, y, z)',
        missing_args2 = 'Tutti gli argomenti devono essere compilati!',
        no_access = 'Non hai accesso a questo comando',
        company_too_poor = 'La tua azienda è povera',
        item_not_exist = 'Oggetto inesistente',
        too_heavy = 'Inventario pieno',
        location_not_exist = 'Destinazione Inesistente',
        duplicate_license = 'Licenza Rockstar Duplicata',
        no_valid_license = 'Licenza Rockstar non Valida',
        not_whitelisted = 'Non sei nella Allowlist',
        server_already_open = 'Il server è già aperto',
        server_already_closed = 'Il server è già chiuso',
        no_permission = 'Non hai i permessi necessari..',
        no_waypoint = 'Nessun marker impostato.',
        tp_error = 'Errore durante il TP.'
    },
    success = {
        server_opened = 'Il server ora è aperto',
        server_closed = 'Il server ora è chiuso',
        teleported_waypoint = 'TP al marker.'
    },
    info = {
        received_paycheck = 'Hai ricevuto la paga di $%{value}',
        job_info = 'Lavoro: %{value} | Grado: %{value2} | Stato: %{value3}',
        gang_info = 'Gang: %{value} | Grado: %{value2}',
        on_duty = 'Sei in servizio!',
        off_duty = 'Sei fuori servizio!',
        checking_ban = 'Ciao %s. Sto controllando che tu non sia bannato!',
        join_server = 'Benvenuto %s su {Server Name}.',
        checking_whitelisted = 'Ciao %s. Sto controllando la allowlist.',
        exploit_banned = 'Sei stato bannato per Cheating o Exploit. Apri un ticket per maggiori informazioni: %{discord}',
        exploit_dropped = 'Sei stato espulso per Exploit'
    },
    command = {
        tp = {
            help = 'TP su ID Gioctore o Coordinate (Solo Admin)',
            params = {
                x = {name = 'id/x', help = 'ID Giocatore o Posizione X'},
                y = {name = 'y', help = 'Posizione Y'},
                z = {name = 'z', help = 'Posizione Z'}
            }
        },
        tpm = {help = 'TP al Marker (Solo Admin)'},
        togglepvp = {help = 'Togli PVP al server (Solo Admin)'},
        addpermission = {
            help = 'Dai i permessi ad un Giocatore (Solo God)',
            params = {
                id = {name = 'id', help = 'ID Giocatore'},
                permission = {name = 'permessi', help = 'Livello Permessi'}
            }
        },
        removepermission = {
            help = 'Rimuovi i permessi ad un Giocatore (Solo God)',
            params = {
                id = {name = 'id', help = 'ID Giocatore'},
                permission = {name = 'permessi', help = 'Livello Permessi'}
            }
        },
        openserver = {help = 'Apri il server a tutti (Solo Admin)'},
        closeserver = {
            help = 'Chidi il server e rendilo accessibile solo a chi ha i permessi (Solo Admin)',
            params = {
                reason = {
                    name = 'motivo',
                    help = 'Motivo di chiusura del server (opzionale)'
                }
            }
        },
        car = {
            help = 'Spawna Veicolo (Solo Admin)',
            params = {model = {name = 'modello', help = 'Nome del veicolo'}}
        },
        dv = {help = 'Elimina Veicolo (Solo Admin)'},
        givemoney = {
            help = 'Dai soldi ad un Giocatore (Solo Admin)',
            params = {
                id = {name = 'id', help = 'ID Giocatore'},
                moneytype = {
                    name = 'tipo',
                    help = 'Tipo di soldi (cash, bank, crypto)'
                },
                amount = {name = 'importo', help = 'Importo'}
            }
        },
        setmoney = {
            help = 'Imposta i soldi ad un Giocatore (Solo Admin)',
            params = {
                id = {name = 'id', help = 'ID Giocatore'},
                moneytype = {
                    name = 'tipo',
                    help = 'Tipo di soldi (cash, bank, crypto)'
                },
                amount = {name = 'importo', help = 'Importo'}
            }
        },
        job = {help = 'Controlla il tuo Lavoro'},
        setjob = {
            help = 'Imposta Lavoro ad un Giocatore (Solo Admin)',
            params = {
                id = {name = 'id', help = 'ID Giocatore'},
                job = {name = 'lavoro', help = 'Nome Lavoro'},
                grade = {name = 'grado', help = 'Grado'}
            }
        },
        gang = {help = 'Controlla la tua Fazione'},
        setgang = {
            help = 'Imposta Fazione ad un Giocatore (Solo Admin)',
            params = {
                id = {name = 'id', help = 'ID Giocatore'},
                gang = {name = 'fazione', help = 'Nome Fazione'},
                grade = {name = 'grado', help = 'Grado'}
            }
        },
        ooc = {help = 'Messaggio OOC'},
        me = {
            help = 'Mostra Messaggio circostante',
            params = {message = {name = 'messaggio', help = 'Messaggio'}}
        }
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

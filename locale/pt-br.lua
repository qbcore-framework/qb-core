local Translations = {
    error = {
        not_online = 'Jogador não está online',
        wrong_format = 'Formato incorreto',
        missing_args = 'Nem todos os argumentos foram inseridos (x, y, z)',
        missing_args2 = 'Todos os argumentos devem ser preenchidos!',
        no_access = 'Sem acesso a este comando',
        company_too_poor = 'Seu empresa está quebrada',
        item_not_exist = 'O item não existe',
        too_heavy = 'Iventário cheio',
        location_not_exist = 'O local não existe',
        duplicate_license = 'Licença da Rockstar duplicada encontrada',
        no_valid_license  = 'Nenhuma licença da Rockstar válida encontrada',
        not_whitelisted = 'Você não está na lista branca(whitelist) deste servidor',
        server_already_open = 'O servidor já está aberto',
        server_already_closed = 'O servidor já está fechado',
        no_permission = 'Você não tem permissões para isso..',
        no_waypoint = 'Nenhum local definido.',
        tp_error = 'Erro ao teletransportar.',
        connecting_database_error = 'Ocorreu um erro de banco de dados ao conectar-se ao servidor. (O servidor SQL está ativado?)',
        connecting_database_timeout = 'A conexão com o banco de dados expirou. (O servidor SQL está ativado?)',
    },
    success = {
        server_opened = 'O servidor foi aberto',
        server_closed = 'O servidor foi fechado',
        teleported_waypoint = 'Teleportado para local marcado.',
    },
    info = {
        received_paycheck = 'Você recebeu seu salário de $%{value}',
        job_info = 'Trabalho: %{value} | Grau: %{value2} | Serviço: %{value3}',
        gang_info = 'Gangue: %{value} | Grau: %{value}',
        on_duty = 'Você agora está de plantão!',
        off_duty = 'Você agora está de folga!',
        checking_ban = 'Olá %s. Estamos verificando se você foi banido.',
        join_server = 'Bem-vindo %s a {Nome do servidor}.',
        checking_whitelisted = 'Olá %s. Estamos verificando sua whitelist.',
        exploit_banned = 'Você foi banido por trapacear. Confira nosso Discord para mais informações: %{discord}',
        exploit_dropped = 'Você foi expulso por exploração',
    },
    command = {
        tp = {
            help = 'TP Para Jogador ou Coordenadas (Somente administrador)',
            params = {
                x = { name = 'id/x', help = 'ID do jogador ou posição X'},
                y = { name = 'y', help = 'posição Y'},
                z = { name = 'z', help = 'posição Z'},
            },
        },
        tpm = { help = 'TP Para Marcador (Somente administrador)' },
        togglepvp = { help = 'Alternar PVP no servidor (Somente administrador)' },
        addpermission = {
            help = 'Dê permissões ao jogador (Só Deus)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                permission = { name = 'permissão', help = 'Nível de permissão' },
            },
        },
        removepermission = {
            help = 'Remover permissões do jogador (Só Deus)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                permission = { name = 'permissão', help = 'Nível de permissão' },
            },
        },
        openserver = { help = 'Abra o servidor para todos (somente administrador)' },
        closeserver = {
            help = 'Feche o servidor para pessoas sem permissões (somente administrador)',
            params = {
                reason = { name = 'motivo', help = 'Motivo do fechamento (opcional)' },
            },
        },
        car = {
            help = 'Criar Veículo (somente administrador)',
            params = {
                model = { name = 'modelo', help = 'Modelo do veículo' },
            },
        },
        dv = { help = 'Excluir veículo (somente administrador)' },
        givemoney = {
            help = 'Dar dinheiro a um jogador (somente administrador)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                moneytype = { name = 'tipo_dinheiro', help = 'Tipo de dinheiro (cash, bank, crypto)' },
                amount = { name = 'quantia', help = 'Quantia de dinheiro' },
            },
        },
        setmoney = {
            help = 'Definir a quantidade de dinheiro do jogador (somente administrador)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                moneytype = { name = 'tipo_dinheiro', help = 'Tipo de dinheiro (cash, bank, crypto)' },
                amount = { name = 'quantia', help = 'Quantia de dinheiro' },
            },
        },
        job = { help = 'Verifique seu trabalho' },
        setjob = {
            help = 'Definir o trabalho do jogador (somente administrador)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                job = { name = 'trabalho', help = 'Nome do trabalho' },
                grade = { name = 'grau', help = 'Grau do trabalho' },
            },
        },
        gang = { help = 'Verifique sua gangue' },
        setgang = {
            help = 'Definir a gangue do jogador (somente administrador)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                gang = { name = 'gangue', help = 'Nome da gangue' },
                grade = { name = 'grau', help = 'Grau da gangue' },
            },
        },
        ooc = { help = 'Mensagem de bate-papo OOC' },
        me = {
            help = 'Mostrar mensagem local',
            params = {
                message = { name = 'mensagem', help = 'Mensagem para enviar' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

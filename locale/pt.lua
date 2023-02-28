local Translations = {
    error = {
        not_online = 'O jogador não está online',
        wrong_format = 'Formato inválido',
        missing_args = 'Não introduziste todos os argumentos (x, y, z)',
        missing_args2 = 'Todos os argumentos têm de ser preenchidos!',
        no_access = 'Não tens acesso a este comando',
        company_too_poor = 'A tua empresa está falida',
        item_not_exist = 'O item não existe',
        too_heavy = 'Inventário cheio',
        location_not_exist = 'Localização não existe',
        duplicate_license = 'Licença Rockstar duplicada',
        no_valid_license  = 'Licença Rockstar não encontrada',
        not_whitelisted = 'Não estás na whitelist deste servidor',
        server_already_open = 'O Servidor já se encontra aberto',
        server_already_closed = 'O Servidor já se encontra fechado',
        no_permission = 'Não tem permissões para isto',
        no_waypoint = 'Não colocou nenhum waypoint',
        tp_error = 'Erro ao teleportar',
        connecting_database_error = 'Um erro na base de dados ocorreu enquanto se conecatava ao servidor. (SQL Server Ligado?)',
        connecting_database_timeout = 'Falhou a ligação à base de dados. (SQL server Ligado?)',
    },
    success = {
        server_opened = 'O Servidor abriu',
        server_closed = 'O Servidor fechou',
        teleported_waypoint = 'Teleportado para o waypoint.',
    },
    info = {
        received_paycheck = 'Recebeste o pagamento de %{value}€',
        job_info = 'Emprego: %{value} | Grau: %{value2} | Serviço: %{value3}',
        gang_info = 'Gang: %{value} | Grau: %{value2}',
        on_duty = 'Agora estás de serviço!',
        off_duty = 'Agora estás fora de serviço!',
        checking_ban = 'Olá %s. Estamos a verificar se estás banido.',
        join_server = 'Bem vindo %s ao {Server Name}.',
        checking_whitelisted = 'Bem vindo %s. Estamos a verificiar se estás na whitelist.',
        exploit_banned = 'Foste banidos por cheats. Para mais informações visita o nosso discord: %{discord}',
        exploit_dropped = 'Foste kickado por cheats!',
    },
    command = {
        tp = {
            help = 'TP para jogador ou coordenadas (Apenas Admin)',
            params = {
                x = { name = 'id/x', help = 'ID do jogador ou posição X'},
                y = { name = 'y', help = 'Posição Y'},
                z = { name = 'z', help = 'Posição Z'},
            },
        },
        tpm = { help = 'TP para Marcador (Apenas Admin)' },
        togglepvp = { help = 'Ligar /Desligar PVP no servidor (Apenas Admin)' },
        addpermission = {
            help = 'Dar Permissões a jogador (Apenas God)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                permission = { name = 'permission', help = 'Nivel de permissão' },
            },
        },
        removepermission = {
            help = 'Remover permissão de jogador (Apenas God)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                permission = { name = 'permission', help = 'Nivel de permissão' },
            },
        },
        openserver = { help = 'Abrir o Servidor para todos (Apenas Admin)' },
        closeserver = {
            help = 'Fechar o servidor para todos excepto Admins (Apenas Admin)',
            params = {
                reason = { name = 'reason', help = 'Razão para fechar(opcional)' },
            },
        },
        car = {
            help = 'Spawnar Veículo (Apenas Admin)',
            params = {
                model = { name = 'model', help = 'Modelo do veículo' },
            },
        },
        dv = { help = 'Apagar Veículo (Apenas Admin)' },
        givemoney = {
            help = 'Dar dinheiro a jogador (Apenas Admin)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                moneytype = { name = 'moneytype', help = 'Tipo (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Quantidade de dinheiro' },
            },
        },
        setmoney = {
            help = 'Definir a quantia de dinheiro do jogador (Apenas Admin)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                moneytype = { name = 'moneytype', help = 'Tipo(cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Quantidade de dinheiro' },
            },
        },
        job = { help = 'Ver o teu trabalho' },
        setjob = {
            help = 'Definir o trabalho de 1 jogador (Apenas Admin)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                job = { name = 'job', help = 'Nome do trabalho' },
                grade = { name = 'grade', help = 'Nivel do trabalho' },
            },
        },
        gang = { help = 'Ver o teu Gang' },
        setgang = {
            help = 'Definir o Gang de um jogador (Apenas Admin)',
            params = {
                id = { name = 'id', help = 'ID do jogador' },
                gang = { name = 'gang', help = 'Nome do Gang' },
                grade = { name = 'grade', help = 'Nível/ Posição no Gang' },
            },
        },
        ooc = { help = 'Mensagem Chat em OOC' },
        me = {
            help = 'Mostrar Mensagem local',
            params = {
                message = { name = 'message', help = 'Menssagem  a enviar' }
            },
        },
    },
}
if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

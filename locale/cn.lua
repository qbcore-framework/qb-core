local Translations = {
    error = {
        not_online = '玩家不在线',
        wrong_format = '格式错误',
        missing_args = '请输入必须参数 (x, y, z)',
        missing_args2 = '请输入所有参数!',
        no_access = '你没有权限',
        company_too_poor = '你所在的公司账户目前发不起工资',
        item_not_exist = '该物品不存在',
        too_heavy = '背包已满',
        location_not_exist = '位置不存在',
        duplicate_license = '发现重复的 Rockstar 许可证',
        no_valid_license  = '未找到有效的 Rockstar 许可证',
        not_whitelisted = '您没有被列入此服务器的白名单',
        server_already_open = '服务器已打开',
        server_already_closed = '服务器已关闭',
        no_permission = '您没有此权限..',
        no_waypoint = '无GPS点位设置.',
        tp_error = '传送时出错.',
        connecting_database_error = '连接到服务器时发生数据库错误。(SQL server是否已打开?)',
        connecting_database_timeout = '与数据库的连接超时。(SQL server是否已打开?)',
    },
    success = {
        server_opened = '服务器已打开',
        server_closed = '服务器已关闭',
        teleported_waypoint = '传送至航路点.',
    },
    info = {
        received_paycheck = '你收到的薪水是 $%{value}',
        job_info = '工作: %{value} | 级别: %{value2} | 上班状态: %{value3}',
        gang_info = '帮派: %{value} | 级别: %{value2}',
        on_duty = '你现在开始上班了!',
        off_duty = '从现在开始你下班了!',
        checking_ban = '你好 %s. 我们正在检查您是否被禁止.',
        join_server = '欢迎 %s 加入 {Server Name}.',
        checking_whitelisted = '你好 %s. 我们正在检查您是否在白名单内.',
        exploit_banned = '你因作弊而被禁止。查看Discord了解更多信息:%{discord}',
        exploit_dropped = '你因为被而被踢出',
    },
    command = {
        tp = {
            help = 'TP至玩家或坐标(仅限管理员)',
            params = {
                x = { name = 'id/x', help = '玩家ID或X位置'},
                y = { name = 'y', help = 'Y位置'},
                z = { name = 'z', help = 'Z位置'},
            },
        },
        tpm = { help = 'TP到标记(仅限管理员)' },
        togglepvp = { help = '切换服务器上的PVP(仅限管理员)' },
        addpermission = {
            help = '授予玩家权限(仅限God)',
            params = {
                id = { name = 'id', help = '玩家ID' },
                permission = { name = 'permission', help = '权限级别' },
            },
        },
        removepermission = {
            help = '删除玩家权限(仅限上帝)',
            params = {
                id = { name = 'id', help = '玩家ID' },
                permission = { name = 'permission', help = '权限级别' },
            },
        },
        openserver = { help = '为每个人打开服务器(仅限管理员)' },
        closeserver = {
            help = '为没有权限的人关闭服务器(仅限管理员)',
            params = {
                reason = { name = 'reason', help = '关闭原因(可选)' },
            },
        },
        car = {
            help = '刷出车辆(仅限管理员)',
            params = {
                model = { name = 'model', help = '车辆型号名称' },
            },
        },
        dv = { help = '删除车辆(仅限管理员)' },
        givemoney = {
            help = '给玩家钱(仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家ID' },
                moneytype = { name = 'moneytype', help = '货币类型(cash, bank, crypto)' },
                amount = { name = 'amount', help = '数量' },
            },
        },
        setmoney = {
            help = '设置玩家金额(仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家ID' },
                moneytype = { name = 'moneytype', help = '货币类型(cash, bank, crypto)' },
                amount = { name = 'amount', help = '数量' },
            },
        },
        job = { help = '检查您的工作' },
        setjob = {
            help = '设置玩家工作(仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家ID' },
                job = { name = 'job', help = '工作名称' },
                grade = { name = 'grade', help = '工作级别' },
            },
        },
        gang = { help = '检查你的帮派' },
        setgang = {
            help = '设置玩家作业(仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家ID' },
                gang = { name = 'gang', help = '帮派名称' },
                grade = { name = 'grade', help = '帮派级别' },
            },
        },
        ooc = { help = 'OOC聊天消息' },
        me = {
            help = '显示本地消息',
            params = {
                message = { name = 'message', help = '要发送的消息' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'cn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
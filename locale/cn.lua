local Translations = {
    error = {
        not_online = '玩家不在线',
        wrong_format = '格式不正确',
        missing_args = '请填写以下参数 (x, y, z)',
        missing_args2 = '必须填写所有参数!',
        no_access = '无法访问此命令',
        company_too_poor = '你所在的公司账户目前发不起工资',
        item_not_exist = '该物品不存在',
        too_heavy = '背包已满',
        location_not_exist = '该位置不存在',
        duplicate_license = '发现重复的 Rockstar 许可证',
        no_valid_license  = '未找到有效的 Rockstar 许可证',
        not_whitelisted = '您没有被列入此服务器的白名单',
        server_already_open = '服务器已经开启',
        server_already_closed = '服务器已经关闭',
        no_permission = '您无权执行此操作..',
        no_waypoint = '没有设置导航点.',
        tp_error = '传送时出错.',
    },
    success = {
        server_opened = '服务器已开启',
        server_closed = '服务器已关闭',
        teleported_waypoint = '传送至导航点.',
    },
    info = {
        received_paycheck = '你收到了你的薪水 $%{value}',
        job_info = '职业: %{value} | 等级: %{value2} | 上班状态: %{value3}',
        gang_info = '帮派: %{value} | 等级: %{value2}',
        on_duty = '你现在已上班!',
        off_duty = '你现在已下班!',
        checking_ban = '你好 %s. 我们正在检查你是否被封禁.',
        join_server = '欢迎 %s 来到 {Server Name}.',
        checking_whitelisted = '你好 %s. 我们正在检查你是否在白名单内.',
        exploit_banned = '你因作弊被封禁，查看我们的 Discord 了解更多信息: %{discord}',
        exploit_dropped = '你因作弊被踢出服务器',
    },
    command = {
        tp = {
            help = '传送到玩家或坐标（仅限管理员）',
            params = {
                x = { name = 'id/x', help = '玩家 ID 或 X 位置'},
                y = { name = 'y', help = 'Y 位置'},
                z = { name = 'z', help = 'Z 位置'},
            },
        },
        tpm = { help = '传送到到导航点（仅限管理员）' },
        togglepvp = { help = '在服务器上切换 PVP（仅限管理员）' },
        addpermission = {
            help = '授予玩家权限(仅限God权限组)',
            params = {
                id = { name = 'id', help = '玩家ID' },
                permission = { name = 'permission', help = '权限等级' },
            },
        },
        removepermission = {
            help = '移除玩家权限 (仅限God权限组)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                permission = { name = 'permission', help = '权限等级' },
            },
        },
        openserver = { help = '向所有人开放服务器 (仅限管理员)' },
        closeserver = {
            help = '踢出没有管理员权限的玩家 (仅限管理员)',
            params = {
                reason = { name = 'reason', help = '关闭理由(可选)' },
            },
        },
        car = {
            help = '生成车辆 (仅限管理员)',
            params = {
                model = { name = 'model', help = '模型型号名称' },
            },
        },
        dv = { help = '删除车辆 (仅限管理员)' },
        givemoney = {
            help = '给玩家金钱 (仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                moneytype = { name = 'moneytype', help = '金钱类型 (cash, bank, crypto)' },
                amount = { name = 'amount', help = '金钱数额' },
            },
        },
        setmoney = {
            help = '设置玩家金钱金额 (仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                moneytype = { name = 'moneytype', help = '金钱种类 (cash, bank, crypto)' },
                amount = { name = 'amount', help = '金钱数额' },
            },
        },
        job = { help = '查看你的工作' },
        setjob = {
            help = '设置玩家职业 (仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                job = { name = 'job', help = '职业名称ID' },
                grade = { name = 'grade', help = '职业等级' },
            },
        },
        gang = { help = '查看你的帮派' },
        setgang = {
            help = '为玩家设置帮派 (仅限管理员)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                gang = { name = 'gang', help = '帮派名称ID' },
                grade = { name = 'grade', help = '帮派等级' },
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

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

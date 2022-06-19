local Translations = {
    error = {
        not_online = '玩家不在线',
        wrong_format = '格式错误',
        missing_args = '请输入必须参数 (x, y, z)',
        missing_args2 = '请输入所有参数!',
        no_access = '你没有权限',
        company_too_poor = '你的老板破产了',
        item_not_exist = '物品不存在',
        too_heavy = '背包已满'
    },
    success = {},
    info = {
        received_paycheck = '你收到了你的工资 $%{value}',
        job_info = '工作: %{value} | 级别: %{value2} | 责任: %{value3}',
        gang_info = '团队: %{value} | 级别: %{value2}',
        on_duty = '你开始工作了!',
        off_duty = '你现在下班了!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

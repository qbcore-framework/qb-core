local Translations = {
    error = {
        not_online                  = '玩家不在線上',
        wrong_format                = '格式不正確',
        missing_args                = '尚未輸入所有參數 (x, y, z)',
        missing_args2               = '必須填寫所有參數!',
        no_access                   = '無法使用此指令',
        company_too_poor            = '您的雇主已破產',
        item_not_exist              = '物品不存在',
        too_heavy                   = '背包已滿',
        location_not_exist          = '位置不存在',
        duplicate_license           = '[QBCORE] - 發現重複的 Rockstar 授權',
        no_valid_license            = '[QBCORE] - 找不到有效的 Rockstar 授權',
        not_whitelisted             = '[QBCORE] - 您不在此伺服器的白名單中',
        server_already_open         = '伺服器已經開啟',
        server_already_closed       = '伺服器已經關閉',
        no_permission               = '您沒有此權限..',
        no_waypoint                 = '尚未設置導航點',
        tp_error                    = '傳送時發生錯誤',
        ban_table_not_found         = '[QBCORE] - 無法在資料庫中找到封禁清單。請確認您已正確匯入 SQL 檔案。',
        connecting_database_error   = '[QBCORE] - 連接資料庫時發生錯誤。請確保 SQL 伺服器正在運行,且 server.cfg 檔案中的設定正確。',
        connecting_database_timeout = '[QBCORE] - 資料庫連接超時。請確保 SQL 伺服器正在運行,且 server.cfg 檔案中的設定正確。',
    },
    success = {
        server_opened = '伺服器已經開啟',
        server_closed = '伺服器已經關閉',
        teleported_waypoint = '傳送至導航點。',
    },
    info = {
        received_paycheck = '您收到了 $%{value} 的薪水',
        job_info = '工作: %{value} | 等級: %{value2} | 上班狀態: %{value3}',
        gang_info = '幫派: %{value} | 等級: %{value2}',
        on_duty = '您現在已經上班了!',
        off_duty = '您現在已經下班了!',
        checking_ban = '你好 %s,我們正在檢查您是否被封禁',
        join_server = '歡迎 %s 加入 {Server Name}',
        checking_whitelisted = '你好 %s,我們正在檢查您的白名單權限',
        exploit_banned = '您因作弊行為而被封禁。請查看我們的 Discord 以獲取更多資訊: %{discord}',
        exploit_dropped = '您因使用外掛程式而被踢出伺服器',
    },
    command = {
        tp = {
            help = '傳送至玩家或座標 (僅限管理員)',
            params = {
                x = { name = 'id/x', help = '玩家 ID 或 X 座標' },
                y = { name = 'y', help = 'Y 座標' },
                z = { name = 'z', help = 'Z 座標' },
            },
        },
        tpm = { help = '傳送至標記點 (僅限管理員)' },
        togglepvp = { help = '切換伺服器 PVP 狀態 (僅限管理員)' },
        addpermission = {
            help = '給予玩家權限 (僅限最高權限)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                permission = { name = 'permission', help = '權限等級' },
            },
        },
        removepermission = {
            help = '移除玩家權限 (僅限最高權限)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                permission = { name = 'permission', help = '權限等級' },
            },
        },
        openserver = { help = '開放伺服器給所有人 (僅限管理員)' },
        closeserver = {
            help = '關閉伺服器給無權限者 (僅限管理員)',
            params = {
                reason = { name = 'reason', help = '關閉原因 (選填)' },
            },
        },
        car = {
            help = '生成載具 (僅限管理員)',
            params = {
                model = { name = 'model', help = '載具型號名稱' },
            },
        },
        dv = { help = '刪除載具 (僅限管理員)' },
        dvall = { help = '刪除所有載具 (僅限管理員)' },
        dvp = { help = '刪除所有 NPC (僅限管理員)' },
        dvo = { help = '刪除所有物件 (僅限管理員)' },
        givemoney = {
            help = '給予玩家金錢 (僅限管理員)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                moneytype = { name = 'moneytype', help = '金錢類型 (現金, 銀行, 加密貨幣)' },
                amount = { name = 'amount', help = '金額' },
            },
        },
        setmoney = {
            help = '設定玩家金錢數量 (僅限管理員)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                moneytype = { name = 'moneytype', help = '金錢類型 (現金, 銀行, 加密貨幣)' },
                amount = { name = 'amount', help = '金額' },
            },
        },
        job = { help = '查看你的工作' },
        setjob = {
            help = '設定玩家工作 (僅限管理員)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                job = { name = 'job', help = '工作名稱' },
                grade = { name = 'grade', help = '工作等級' },
            },
        },
        gang = { help = '查看你所在的幫派' },
        setgang = {
            help = '設定玩家幫派 (僅限管理員)',
            params = {
                id = { name = 'id', help = '玩家 ID' },
                gang = { name = 'gang', help = '幫派名稱' },
                grade = { name = 'grade', help = '幫派等級' },
            },
        },
        ooc = { help = 'OOC 聊天訊息' },
        me = {
            help = '顯示本地訊息',
            params = {
                message = { name = 'message', help = '要發送的訊息' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'zh-tw' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

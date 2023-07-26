local Translations = {
    error = {
        not_online = 'プレイヤーはオフラインです。',
        wrong_format = '無効なフォーマットです。',
        missing_args = 'すべての引数が入力されていません。(x, y, z)',
        missing_args2 = 'すべての引数を入力する必要があります!',
        no_access = 'このコマンドは利用不可です。',
        company_too_poor = 'あなたの雇用主は破産しました。',
        item_not_exist = 'アイテムは無効です。',
        too_heavy = 'これ以上インベントリにアイテムは入りません。',
        location_not_exist = '場所が無効です。',
        duplicate_license = '重複したRockstarアカウントが見つかりました。',
        no_valid_license  = '有効なRockstarアカウントが見つかりませんでした。',
        not_whitelisted = 'あなたはこのサーバーでホワイトリストに登録されていません。',
        server_already_open = 'サーバーは既に起動されています。',
        server_already_closed = 'サーバーは既に閉鎖されています。',
        no_permission = 'あなたはこの操作の権限を持っていません。',
        no_waypoint = '行き先が設定されていません。',
        tp_error = 'テレポート中にエラーが発生しました。',
        connecting_database_error = 'サーバーに接続中にデータベースでエラーが発生しました。SQLサーバーが起動しているか確認してください。',
        connecting_database_timeout = 'サーバーに接続中にデータベースでタイムアウトが発生しました。SQLサーバーが起動しているか確認してください。',
    },
    success = {
        server_opened = 'サーバーが起動しました。',
        server_closed = 'サーバーが閉鎖されました',
        teleported_waypoint = 'テレポートしました。',
    },
    info = {
        received_paycheck = '$%{value}の給料を受け取りました。',
        job_info = '職業: %{value} | 階級: %{value2} | 勤務状態: %{value3}',
        gang_info = 'ギャング: %{value} | 階級: %{value2}',
        on_duty = '出勤しました!',
        off_duty = '退勤しました!',
        checking_ban = 'BANの状態を確認します。',
        join_server = '{Server Name}へようこそ!',
        checking_whitelisted = 'ホワイトリストに登録されているか確認します。',
        exploit_banned = 'あなたはチートを使用した疑いがあるためBANされています。Discordサーバーで詳細を確認してください。: %{discord}',
        exploit_dropped = 'あなたはキックされました。',
    },
    command = {
        tp = {
            help = 'プレイヤーまたは座標へのテレポートを行います (管理者専用)',
            params = {
                x = { name = 'id/x', help = 'プレイヤーIDもしくはX座標を入力'},
                y = { name = 'y', help = 'Y座標を入力'},
                z = { name = 'z', help = 'Z座標を入力'},
            },
        },
        tpm = { help = 'マーカーへテレポートします (管理者専用)' },
        togglepvp = { help = 'PVPの状態を切り替えます (管理者専用)' },
        addpermission = {
            help = 'プレイヤーに権限を付与します (God Only)',
            params = {
                id = { name = 'プレイヤーID', help = 'プレイヤーIDを入力' },
                permission = { name = '権限', help = '権限のレベルを入力' },
            },
        },
        removepermission = {
            help = 'プレイヤーの権限を剥奪します (God Only)',
            params = {
                id = { name = 'プレイヤーID', help = 'プレイヤーIDを入力' },
                permission = { name = '権限', help = '権限のレベルを入力' },
            },
        },
        openserver = { help = 'サーバーを公開します (管理者専用)' },
        closeserver = {
            help = '権限がないプレイヤーに対しサーバーを閉鎖します (管理者専用)',
            params = {
                reason = { name = '理由', help = '閉鎖の理由を入力してください (任意)' },
            },
        },
        car = {
            help = '車両をスポーンします (管理者専用)',
            params = {
                model = { name = 'モデル', help = '車両のモデルを入力' },
            },
        },
        dv = { help = '車両を削除します (管理者専用)' },
        givemoney = {
            help = 'プレイヤーにお金を付与します (管理者専用)',
            params = {
                id = { name = 'プレイヤーID', help = 'プレイヤーIDを入力' },
                moneytype = { name = '入金先', help = 'お金の入金先を指定してください。(cash, bank, crypto)' },
                amount = { name = '金額', help = '金額をしてください' },
            },
        },
        setmoney = {
            help = 'プレイヤーのお金を指定します (管理者専用)',
            params = {
                id = { name = 'プレイヤーID', help = 'プレイヤーIDを入力' },
                moneytype = { name = '指定先', help = 'お金の指定先を指定してください。(cash, bank, crypto)' },
                amount = { name = '金額', help = '金額を指定してください' },
            },
        },
        job = { help = '現在の仕事を確認します' },
        setjob = {
            help = 'プレイヤーの仕事を指定します (管理者専用)',
            params = {
                id = { name = 'プレイヤーID', help = 'プレイヤーIDを入力' },
                job = { name = '仕事', help = '仕事名を入力' },
                grade = { name = '階級', help = '階級を指定' },
            },
        },
        gang = { help = '現在のギャング所属状況を確認します' },
        setgang = {
            help = 'プレイヤーの所属するギャングのチームを指定します (管理者専用)',
            params = {
                id = { name = 'プレイヤーID', help = 'プレイヤーIDを入力' },
                gang = { name = 'ギャング', help = 'ギャングのチーム名を入力' },
                grade = { name = '階級', help = '階級を指定' },
            },
        },
        ooc = { help = 'OOCチャットメッセージ' },
        me = {
            help = 'ローカルメッセージを表示',
            params = {
                message = { name = 'メッセージ', help = 'メッセージを送信します' }
            },
        },
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

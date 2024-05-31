local Translations = {
    error = {
        not_online                  = 'பிளேயர் ஆன்லைனில் இல்லை',
        wrong_format                = 'தவறான வடிவம்',
        missing_args                = 'ஒவ்வொரு வாதமும் உள்ளிடப்படவில்லை (x, y, z)',
        missing_args2               = 'அனைத்து வாதங்களும் நிரப்பப்பட வேண்டும்!',
        no_access                   = 'இந்த கட்டளைக்கு அனுமதி இல்லை',
        company_too_poor            = 'உங்கள் முதலாளி இப்போது ஏழை',
        item_not_exist              = 'பொருள் இல்லை',
        too_heavy                   = 'இன்வெண்ட்டரி நிரம்பியது',
        location_not_exist          = 'இடம் இல்லை',
        duplicate_license           = '[QBCORE] - டூப்ளிகேட் ராக்ஸ்டார் உரிமம் கிடைத்தது',
        no_valid_license            = '[QBCORE] - சரியான ராக்ஸ்டார் உரிமம் இல்லை',
        not_whitelisted             = '[QBCORE] - இந்த சேவையகத்திற்கு நீங்கள் அனுமதிப்பட்டியலில் இல்லை',
        server_already_open         = 'சர்வர் ஏற்கனவே திறக்கப்பட்டுள்ளது',
        server_already_closed       = 'சர்வர் ஏற்கனவே மூடப்பட்டுள்ளது',
        no_permission               = 'இதற்கான அனுமதி உங்களிடம் இல்லை..',
        no_waypoint                 = 'வழிப்பாதை அமைக்கப்படவில்லை.',
        tp_error                    = 'டெலிபோர்ட் செய்யும் போது பிழை.',
        connecting_database_error   = '[QBCORE] - சேவையகத்துடன் இணைக்கும் போது தரவுத்தளப் பிழை ஏற்பட்டது. (SQL சர்வர் இயக்கத்தில் உள்ளதா?)',
        connecting_database_timeout = '[QBCORE] - தரவுத்தளத்திற்கான இணைப்பு நேரம் முடிந்தது. (SQL சர்வர் இயக்கத்தில் உள்ளதா?)',
    },
    success = {
        server_opened = 'சர்வர் திறக்கப்பட்டது',
        server_closed = 'சர்வர் மூடப்பட்டுள்ளது',
        teleported_waypoint = 'வேபாயிண்டிற்கு டெலிபோர்ட் செய்யப்பட்டது.',
    },
    info = {
        received_paycheck = 'நீங்கள் உங்கள் சம்பளத்தை பெற்றுள்ளீர்கள் $%{value}',
        job_info = 'பணி: %{value} | கிரேடு: %{value2} | கடமை: %{value3}',
        gang_info = 'கும்பல் %{value} | கிரேடு: %{value2}',
        on_duty = 'நீங்கள் இப்போது கடமையில் இருக்கிறீர்கள்!',
        off_duty = 'நீங்கள் இப்போது கடமையிலிருந்து விடுபட்டுள்ளீர்கள்!',
        checking_ban = 'வணக்கம் %s. நீங்கள் தடை செய்யப்பட்டுள்ளதா என்பதை நாங்கள் சரிபார்க்கிறோம்.',
        join_server = 'வரவேற்கிறோம் %s to {Server Name}.',
        checking_whitelisted = 'வணக்கம் %s. உங்கள் கொடுப்பனவை நாங்கள் சரிபார்க்கிறோம்.',
        exploit_banned = 'நீங்கள் ஏமாற்றியதற்காக தடை செய்யப்பட்டீர்கள். மேலும் தகவலுக்கு எங்கள் முரண்பாட்டைச் சரிபார்க்கவும்: %{discord}',
        exploit_dropped = 'சுரண்டலுக்காக உதைக்கப்பட்டீர்கள்',
    },
    command = {
        tp = {
            help = 'TP டு பிளேயர் அல்லது Coords (நிர்வாகம் மட்டும்)',
            params = {
                x = { name = 'id/x', help = 'ID of வீரர் அல்லது X நிலை' },
                y = { name = 'y', help = 'Y position' },
                z = { name = 'z', help = 'Z position' },
            },
        },
        tpm = { help = 'TP டு மார்க்கர் (நிர்வாகம் மட்டும்)' },
        togglepvp = { help = 'சர்வரில் பிவிபியை நிலைமாற்று (நிர்வாகம் மட்டும்)' },
        addpermission = {
            help = 'வீரர்களுக்கு அனுமதி கொடுங்கள் (கடவுள் மட்டும்)',
            params = {
                id = { name = 'id', help = 'ID ஆட்டக்காரர்' },
                permission = { name = 'permission', help = 'அனுமதி நிலை' },
            },
        },
        removepermission = {
            help = 'பிளேயர் அனுமதிகளை அகற்று (கடவுள் மட்டும்)',
            params = {
                id = { name = 'id', help = 'ID ஆட்டக்காரர்' },
                permission = { name = 'permission', help = 'அனுமதி நிலை' },
            },
        },
        openserver = { help = 'அனைவருக்கும் சேவையகத்தைத் திறக்கவும் (நிர்வாகம் மட்டும்)' },
        closeserver = {
            help = 'அனுமதி இல்லாதவர்களுக்கு சேவையகத்தை மூடு (நிர்வாகம் மட்டும்)',
            params = {
                reason = { name = 'reason', help = 'மூடுவதற்கான காரணம் (விரும்பினால்)' },
            },
        },
        car = {
            help = 'ஸ்பான் வாகனம் (நிர்வாகம் மட்டும்)',
            params = {
                model = { name = 'model', help = 'வாகனத்தின் மாதிரி பெயர்' },
            },
        },
        dv = { help = 'வாகனத்தை நீக்கு (நிர்வாகம் மட்டும்)' },
        dvall = { help = 'அனைத்து வாகனங்களையும் நீக்கு (நிர்வாகம் மட்டும்)' },
        dvp = { help = 'அனைத்து பெட்களையும் நீக்கு (நிர்வாகம் மட்டும்)' },
        dvo = { help = 'அனைத்து பொருட்களையும் நீக்கு (நிர்வாகம் மட்டும்)' },
        givemoney = {
            help = 'ஒரு வீரருக்கு பணம் கொடுங்கள் (நிர்வாகம் மட்டும்)',
            params = {
                id = { name = 'id', help = 'ID ஆட்டக்காரர்' },
                moneytype = { name = 'moneytype', help = 'பணத்தின் வகை (பணம், வங்கி, கிரிப்டோ)' },
                amount = { name = 'amount', help = 'பணத்தின் அளவு' },
            },
        },
        setmoney = {
            help = 'வீரர்களுக்கான பணத் தொகையை அமைக்கவும் (நிர்வாகம் மட்டும்)',
            params = {
                id = { name = 'id', help = 'ID ஆட்டக்காரர்' },
                moneytype = { name = 'moneytype', help = 'பணத்தின் வகை (பணம், வங்கி, கிரிப்டோ)' },
                amount = { name = 'amount', help = 'பணத்தின் அளவு' },
            },
        },
        job = { help = 'உங்கள் வேலையைச் சரிபார்க்கவும்' },
        setjob = {
            help = 'பிளேயர்ஸ் வேலையை அமைக்கவும் (நிர்வாகம் மட்டும்)',
            params = {
                id = { name = 'id', help = 'ID ஆட்டக்காரர்' },
                job = { name = 'job', help = 'வேலை பெயர்' },
                grade = { name = 'grade', help = 'வேலை தரம்' },
            },
        },
        gang = { help = 'உங்கள் கும்பலைச் சரிபார்க்கவும்' },
        setgang = {
            help = 'பிளேயர்ஸ் கேங்கை அமைக்கவும் (நிர்வாகம் மட்டும்)',
            params = {
                id = { name = 'id', help = 'ID ஆட்டக்காரர்' },
                gang = { name = 'gang', help = 'கும்பல் பெயர்' },
                grade = { name = 'grade', help = 'கும்பல் நிலை' },
            },
        },
        ooc = { help = 'OOC அரட்டை செய்தி' },
        me = {
            help = 'உள்ளூர் செய்தியைக் காட்டு',
            params = {
                message = { name = 'message', help = 'அனுப்ப வேண்டிய செய்தி' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'ta' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
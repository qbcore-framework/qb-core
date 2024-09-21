local Translations = {
    error = {
        not_online                  = 'खिलाडी अनलाइन छैन',
        wrong_format                = 'गलत ढाँचा',
        missing_args                = 'सबै तर्कहरू प्रविष्ट गरिएको छैन (x, y, z)',
        missing_args2               = 'सबै तर्कहरू पूरा गर्नुपर्छ!',
        no_access                   = 'यस आदेशको लागि पहुँच छैन',
        company_too_poor            = 'तपाईंको नियोक्ता टाट पल्टेको छ',
        item_not_exist              = 'वस्तु अवस्थित छैन',
        too_heavy                   = 'इन्वेन्टरी धेरै भरिएको छ',
        location_not_exist          = 'स्थान अवस्थित छैन',
        duplicate_license           = '[QBCORE] - दोहोरिएको रकस्टार लाइसेन्स भेटियो',
        no_valid_license            = '[QBCORE] - मान्य रकस्टार लाइसेन्स भेटिएन',
        not_whitelisted             = '[QBCORE] - तपाईं यस सर्भरको लागि सेतो सूचीमा हुनुहुन्न',
        server_already_open         = 'सर्भर पहिले नै खुल्ला छ',
        server_already_closed       = 'सर्भर पहिले नै बन्द छ',
        no_permission               = 'तपाईंलाई यसका लागि अनुमति छैन।',
        no_waypoint                 = 'वेपॉइंट सेट गरिएको छैन।',
        tp_error                    = 'टेलिपोर्ट गर्दा त्रुटि।',
        ban_table_not_found         = '[QBCORE] - डाटाबेसमा प्रतिबन्ध तालिका फेला पार्न सकेन। कृपया तपाईंले SQL फाइल सही रूपमा आयात गरेको सुनिश्चित गर्नुहोस्।',
        connecting_database_error   = '[QBCORE] - डाटाबेससँग जडान गर्दा त्रुटि भयो। कृपया SQL सर्भर चलिरहेको छ र server.cfg फाइलमा विवरणहरू सही छन् भन्ने सुनिश्चित गर्नुहोस्।',
        connecting_database_timeout = '[QBCORE] - डाटाबेस जडानले समय समाप्त गर्यो। कृपया SQL सर्भर चलिरहेको छ र server.cfg फाइलमा विवरणहरू सही छन् भन्ने सुनिश्चित गर्नुहोस्।',
    },
    success = {
        server_opened = 'सर्भर खोलियो',
        server_closed = 'सर्भर बन्द भयो',
        teleported_waypoint = 'वेपॉइंटमा टेलिपोर्ट भयो।',
    },
    info = {
        received_paycheck = 'तपाईंले $%{value} को तलब प्राप्त गर्नुभयो',
        job_info = 'काम: %{value} | ग्रेड: %{value2} | ड्युटी: %{value3}',
        gang_info = 'ग्याङ: %{value} | ग्रेड: %{value2}',
        on_duty = 'तपाईं अब ड्युटीमा हुनुहुन्छ!',
        off_duty = 'तपाईं अब ड्युटीबाट बाहिर हुनुहुन्छ!',
        checking_ban = 'नमस्ते %s। हामी तपाईं प्रतिबन्धित हुनुहुन्छ कि छैन जाँच गर्दैछौं।',
        join_server = 'स्वागत छ %s {Server Name} मा।',
        checking_whitelisted = 'नमस्ते %s। हामी तपाईंको अनुमतिहरू जाँच्दैछौं।',
        exploit_banned = 'तपाईंलाई धोकाधडीको लागि प्रतिबन्ध लगाइएको छ। थप जानकारीका लागि हाम्रो डिस्कर्ड हेर्नुहोस्: %{discord}',
        exploit_dropped = 'धोकाधडीको लागि तपाईंलाई निकालिएको छ',
    },
    command = {
        tp = {
            help = 'खिलाडी वा निर्देशांकमा टेलिपोर्ट गर्नुहोस् (केवल प्रशासक)',
            params = {
                x = { name = 'id/x', help = 'खिलाडीको ID वा X स्थिति' },
                y = { name = 'y', help = 'Y स्थिति' },
                z = { name = 'z', help = 'Z स्थिति' },
            },
        },
        tpm = { help = 'मार्करमा टेलिपोर्ट गर्नुहोस् (केवल प्रशासक)' },
        togglepvp = { help = 'सर्भरमा PVP सक्रिय/निष्क्रिय गर्नुहोस् (केवल प्रशासक)' },
        addpermission = {
            help = 'खिलाडीलाई अनुमति दिनुहोस् (केवल देवता)',
            params = {
                id = { name = 'id', help = 'खिलाडीको ID' },
                permission = { name = 'permission', help = 'अनुमतिका स्तर' },
            },
        },
        removepermission = {
            help = 'खिलाडीबाट अनुमति हटाउनुहोस् (केवल देवता)',
            params = {
                id = { name = 'id', help = 'खिलाडीको ID' },
                permission = { name = 'permission', help = 'अनुमतिका स्तर' },
            },
        },
        openserver = { help = 'सबैलाई सर्भर खोल्नुहोस् (केवल प्रशासक)' },
        closeserver = {
            help = 'अनुमति बिना मानिसहरूलाई सर्भर बन्द गर्नुहोस् (केवल प्रशासक)',
            params = {
                reason = { name = 'reason', help = 'बन्द गर्ने कारण (वैकल्पिक)' },
            },
        },
        car = {
            help = 'सवारी साधन उत्पन्न गर्नुहोस् (केवल प्रशासक)',
            params = {
                model = { name = 'model', help = 'सवारी साधनको मोडल नाम' },
            },
        },
        dv = { help = 'सवारी साधन मेटाउनुहोस् (केवल प्रशासक)' },
        dvall = { help = 'सबै सवारी साधन मेटाउनुहोस् (केवल प्रशासक)' },
        dvp = { help = 'सबै NPC मेटाउनुहोस् (केवल प्रशासक)' },
        dvo = { help = 'सबै वस्तुहरू मेटाउनुहोस् (केवल प्रशासक)' },
        givemoney = {
            help = 'खिलाडीलाई पैसा दिनुहोस् (केवल प्रशासक)',
            params = {
                id = { name = 'id', help = 'खिलाडीको ID' },
                moneytype = { name = 'moneytype', help = 'पैसाको प्रकार (नगद, बैंक, क्रिप्टो)' },
                amount = { name = 'amount', help = 'पैसाको रकम' },
            },
        },
        setmoney = {
            help = 'खिलाडीको पैसा सेट गर्नुहोस् (केवल प्रशासक)',
            params = {
                id = { name = 'id', help = 'खिलाडीको ID' },
                moneytype = { name = 'moneytype', help = 'पैसाको प्रकार (नगद, बैंक, क्रिप्टो)' },
                amount = { name = 'amount', help = 'पैसाको रकम' },
            },
        },
        job = { help = 'तपाईंको काम जाँच्नुहोस्' },
        setjob = {
            help = 'खिलाडीलाई काम दिनुहोस् (केवल प्रशासक)',
            params = {
                id = { name = 'id', help = 'खिलाडीको ID' },
                job = { name = 'job', help = 'कामको नाम' },
                grade = { name = 'grade', help = 'कामको स्तर' },
            },
        },
        gang = { help = 'तपाईंको ग्याङ जाँच्नुहोस्' },
        setgang = {
            help = 'खिलाडीलाई ग्याङ दिनुहोस् (केवल प्रशासक)',
            params = {
                id = { name = 'id', help = 'खिलाडीको ID' },
                gang = { name = 'gang', help = 'ग्याङको नाम' },
                grade = { name = 'grade', help = 'ग्याङको स्तर' },
            },
        },
        ooc = { help = 'OOC च्याट सन्देश' },
        me = {
            help = 'स्थानीय सन्देश देखाउनुहोस्',
            params = {
                message = { name = 'message', help = 'पठाउनको लागि सन्देश' }
            },
        },
    },
}

if GetConvar('qb_locale', 'en') == 'np' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Locale:new({ phrases = {}, warnOnMissing = true }) -- Fallback to empty locale if needed
    })
end

local Translations = {
    error = {
        not_online = 'მოთამაშე ონლაინში არ არის',
        wrong_format = 'არასწორი ფორმატი',
        missing_args = 'ყველა არგუმენტი არ არის შეყვანილი (x, y, z)',
        missing_args2 = 'ყველა არგუმენტი უნდა იყოს შევსებული!',
        no_access = 'ამ ბრძანებაზე წვდომა არ არის',
        company_too_poor = 'თქვენი დამსაქმებელი ღარიბია',
        item_exist = 'ნივთი არ არსებობს',
        too_heavy = 'ზედმეტად სავსეა ინვენტარი'
    },
    success = {},
    info = {
        received_paycheck = 'თქვენ მიიღეთ თქვენი ხელფასი $%{value}',
        job_info = 'სამუშაო: %{value} | შეფასება: %{value2} | მოვალეობა: %{value3}',
        gang_info = 'ჯგუფი: %{value} | შეფასება: %{value2}',
        on_duty = 'ახლა მორიგე ხარ!',
        off_duty = 'ახლა სამსახურიდან გასული ხარ!'
    }
}

if GetConvar('qb_locale', 'en') == 'ge' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

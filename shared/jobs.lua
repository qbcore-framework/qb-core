QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true

local function createJob(label, type, defaultDuty, offDutyPay, grades)
    return { label = label, type = type, defaultDuty = defaultDuty, offDutyPay = offDutyPay, grades = grades }
end

QBShared.Jobs = {
    ['unemployed'] = createJob('Civilian', nil, true, false, {
        ['0'] = { name = 'Freelancer', payment = 10 }
    }),
    ['bus'] = createJob('Bus', nil, true, false, {
        ['0'] = { name = 'Driver', payment = 50 }
    }),
    ['judge'] = createJob('Honorary', nil, true, false, {
        ['0'] = { name = 'Judge', payment = 100 }
    }),
    ['lawyer'] = createJob('Law Firm', nil, true, false, {
        ['0'] = { name = 'Associate', payment = 50 }
    }),
    ['reporter'] = createJob('Reporter', nil, true, false, {
        ['0'] = { name = 'Journalist', payment = 50 }
    }),
    ['trucker'] = createJob('Trucker', nil, true, false, {
        ['0'] = { name = 'Driver', payment = 50 }
    }),
    ['tow'] = createJob('Towing', nil, true, false, {
        ['0'] = { name = 'Driver', payment = 50 }
    }),
    ['garbage'] = createJob('Garbage', nil, true, false, {
        ['0'] = { name = 'Collector', payment = 50 }
    }),
    ['vineyard'] = createJob('Vineyard', nil, true, false, {
        ['0'] = { name = 'Picker', payment = 50 }
    }),
    ['hotdog'] = createJob('Hotdog', nil, true, false, {
        ['0'] = { name = 'Sales', payment = 50 }
    }),
    ['police'] = createJob('Law Enforcement', 'leo', true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Officer', payment = 75 },
        ['2'] = { name = 'Sergeant', payment = 100 },
        ['3'] = { name = 'Lieutenant', payment = 125 },
        ['4'] = { name = 'Chief', isboss = true, payment = 150 }
    }),
    ['ambulance'] = createJob('EMS', 'ems', true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Paramedic', payment = 75 },
        ['2'] = { name = 'Doctor', payment = 100 },
        ['3'] = { name = 'Surgeon', payment = 125 },
        ['4'] = { name = 'Chief', isboss = true, payment = 150 }
    }),
    ['realestate'] = createJob('Real Estate', nil, true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'House Sales', payment = 75 },
        ['2'] = { name = 'Business Sales', payment = 100 },
        ['3'] = { name = 'Broker', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    }),
    ['taxi'] = createJob('Taxi', nil, true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Driver', payment = 75 },
        ['2'] = { name = 'Event Driver', payment = 100 },
        ['3'] = { name = 'Sales', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    }),
    ['cardealer'] = createJob('Vehicle Dealer', nil, true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Showroom Sales', payment = 75 },
        ['2'] = { name = 'Business Sales', payment = 100 },
        ['3'] = { name = 'Finance', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    }),
    ['mechanic'] = createJob('LS Customs', 'mechanic', true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Novice', payment = 75 },
        ['2'] = { name = 'Experienced', payment = 100 },
        ['3'] = { name = 'Advanced', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    }),
    ['mechanic2'] = createJob('LS Customs', 'mechanic', true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Novice', payment = 75 },
        ['2'] = { name = 'Experienced', payment = 100 },
        ['3'] = { name = 'Advanced', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    }),
    ['mechanic3'] = createJob('LS Customs', 'mechanic', true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Novice', payment = 75 },
        ['2'] = { name = 'Experienced', payment = 100 },
        ['3'] = { name = 'Advanced', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    }),
    ['beeker'] = createJob('Beeker\'s Garage', 'mechanic', true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Novice', payment = 75 },
        ['2'] = { name = 'Experienced', payment = 100 },
        ['3'] = { name = 'Advanced', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    }),
    ['bennys'] = createJob('Benny\'s Original Motor Works', 'mechanic', true, false, {
        ['0'] = { name = 'Recruit', payment = 50 },
        ['1'] = { name = 'Novice', payment = 75 },
        ['2'] = { name = 'Experienced', payment = 100 },
        ['3'] = { name = 'Advanced', payment = 125 },
        ['4'] = { name = 'Manager', isboss = true, payment = 150 }
    })
}

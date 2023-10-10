QBShared = QBShared or {}
QBShared.Gangs = {
    ['none'] = createGang('No Gang', {
        ['0'] = { name = 'Unaffiliated' }
    }),
    ['lostmc'] = createGang('The Lost MC', {
        ['0'] = { name = 'Recruit' },
        ['1'] = { name = 'Enforcer' },
        ['2'] = { name = 'Shot Caller' },
        ['3'] = { name = 'Boss', isboss = true }
    }),
    ['ballas'] = createGang('Ballas', {
        ['0'] = { name = 'Recruit' },
        ['1'] = { name = 'Enforcer' },
        ['2'] = { name = 'Shot Caller' },
        ['3'] = { name = 'Boss', isboss = true }
    }),
    ['vagos'] = createGang('Vagos', {
        ['0'] = { name = 'Recruit' },
        ['1'] = { name = 'Enforcer' },
        ['2'] = { name = 'Shot Caller' },
        ['3'] = { name = 'Boss', isboss = true }
    }),
    ['cartel'] = createGang('Cartel', {
        ['0'] = { name = 'Recruit' },
        ['1'] = { name = 'Enforcer' },
        ['2'] = { name = 'Shot Caller' },
        ['3'] = { name = 'Boss', isboss = true }
    }),
    ['families'] = createGang('Families', {
        ['0'] = { name = 'Recruit' },
        ['1'] = { name = 'Enforcer' },
        ['2'] = { name = 'Shot Caller' },
        ['3'] = { name = 'Boss', isboss = true }
    }),
    ['triads'] = createGang('Triads', {
        ['0'] = { name = 'Recruit' },
        ['1'] = { name = 'Enforcer' },
        ['2'] = { name = 'Shot Caller' },
        ['3'] = { name = 'Boss', isboss = true }
    })
}

local function createGang(label, grades)
    return { label = label, grades = grades }
end

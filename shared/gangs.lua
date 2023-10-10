QBShared = QBShared or {}

local function createGangGrades(grades)
    local gangGrades = {}
    for i, grade in ipairs(grades) do
        gangGrades[tostring(i-1)] = grade
    end
    return gangGrades
end

QBShared.Gangs = {
    none = {
        label = 'No Gang',
        grades = {
            ['0'] = { name = 'Unaffiliated' }
        }
    },
    lostmc = {
        label = 'The Lost MC',
        grades = createGangGrades({
            { name = 'Recruit' },
            { name = 'Enforcer' },
            { name = 'Shot Caller' },
            { name = 'Boss', isboss = true }
        })
    },
    ballas = {
        label = 'Ballas',
        grades = createGangGrades({
            { name = 'Associate' },
            { name = 'Soldier' },
            { name = 'Lieutenant' },
            { name = 'Boss', isboss = true }
        })
    },
    vagos = {
        label = 'Vagos',
        grades = createGangGrades({
            { name = 'Recruit' },
            { name = 'Enforcer' },
            { name = 'Shot Caller' },
            { name = 'Boss', isboss = true }
        })
    },
    cartel = {
        label = 'Cartel',
        grades = createGangGrades({
            { name = 'Recruit' },
            { name = 'Enforcer' },
            { name = 'Shot Caller' },
            { name = 'Boss', isboss = true }
        })
    },
    families = {
        label = 'Families',
        grades = createGangGrades({
            { name = 'Recruit' },
            { name = 'Enforcer' },
            { name = 'Shot Caller' },
            { name = 'Boss', isboss = true }
        })
    },
    triads = {
        label = 'Triads',
        grades = createGangGrades({
            { name = 'Recruit' },
            { name = 'Enforcer' },
            { name = 'Shot Caller' },
            { name = 'Boss', isboss = true }
        })
    }
}

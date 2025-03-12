-- Backwards Compat

local function extractData(source, prefix)
    local state = Player(source).state
    local data = {}

    for key, value in pairs(state) do
        if key:find('^' .. prefix) then
            local shortKey = key:gsub(prefix, '')
            data[shortKey] = value or 'Unknown'
        end
    end

    return data
end

local function CreateLegacyPlayerData(player)
    local source     = player.source
    local state      = Player(source).state
    local legacy     = {}
    legacy.license   = QBCore.Functions.GetIdentifier(source, 'license')
    legacy.source    = source
    legacy.name      = GetPlayerName(source)
    legacy.citizenid = state['citizenid']
    legacy.money     = extractData(source, 'money:')
    legacy.job       = extractData(source, 'job:')
    legacy.gang      = extractData(source, 'gang:')
    legacy.metadata  = extractData(source, 'metadata:')
    legacy.charinfo  = extractData(source, 'charinfo:')
    legacy.position  = extractData(source, 'position:')

    setmetatable(legacy, {
        __index = function(tbl, key)
            if key == 'money' then
                return extractData(source, 'money:')
            elseif key == 'job' then
                return extractData(source, 'job:')
            elseif key == 'gang' then
                return extractData(source, 'gang:')
            elseif key == 'metadata' then
                return extractData(source, 'metadata:')
            elseif key == 'charinfo' then
                return extractData(source, 'charinfo:')
            elseif key == 'position' then
                return extractData(source, 'position:')
            else
                return rawget(tbl, key)
            end
        end,
        __newindex = function(tbl, key, value)
            local state = Player(source).state
            if key == 'money' and type(value) == 'table' then
                for subkey, subvalue in pairs(value) do
                    state:set('money:' .. subkey, subvalue, true)
                end
            elseif key == 'job' and type(value) == 'table' then
                for subkey, subvalue in pairs(value) do
                    state:set('job:' .. subkey, subvalue, true)
                end
            elseif key == 'gang' and type(value) == 'table' then
                for subkey, subvalue in pairs(value) do
                    state:set('gang:' .. subkey, subvalue, true)
                end
            elseif key == 'metadata' and type(value) == 'table' then
                for subkey, subvalue in pairs(value) do
                    state:set('metadata:' .. subkey, subvalue, true)
                end
            elseif key == 'charinfo' and type(value) == 'table' then
                for subkey, subvalue in pairs(value) do
                    state:set('charinfo:' .. subkey, subvalue, true)
                end
            elseif key == 'position' and type(value) == 'table' then
                for subkey, subvalue in pairs(value) do
                    state:set('position:' .. subkey, subvalue, true)
                end
            else
                rawset(tbl, key, value)
            end
        end,
    })
    return legacy
end

-- JSON STUFF

local DynamicDefaults = {
    ['citizenid'] = QBCore.Functions.CreateCitizenId,
    ['charinfo.phone'] = QBCore.Functions.CreatePhoneNumber,
    ['charinfo.account'] = QBCore.Functions.CreateAccountNumber,
    ['metadata.bloodtype'] = function() return QBCore.Functions.GetRandomElement(QBCore.Config.Player.Bloodtypes) end,
    ['metadata.fingerprint'] = QBCore.Functions.CreateFingerId,
    ['metadata.walletid'] = QBCore.Functions.CreateWalletId
}

local function ApplyDynamicDefaults(target)
    for field, func in pairs(DynamicDefaults) do
        local ref = target
        local keys = {}
        for key in field:gmatch('[^.]+') do table.insert(keys, key) end

        for i = 1, #keys - 1 do
            ref[keys[i]] = ref[keys[i]] or {}
            ref = ref[keys[i]]
        end

        ref[keys[#keys]] = ref[keys[#keys]] or func()
    end
end

local function LoadPlayerDefaults()
    local success, defaults = pcall(function()
        return json.decode(LoadResourceFile(resourceName, 'shared/player_defaults.json'))
    end)

    if not success or not defaults or not next(defaults) then
        print('^1[ERROR]^0 Could not load player_defaults.json. Ensure the file is valid JSON and not empty.')
        return {}
    end

    ApplyDynamicDefaults(defaults)
    return defaults
end

local function MergePlayerData(target, defaults, debug)
    for key, value in pairs(defaults) do
        if type(value) == 'table' then
            target[key] = target[key] or {}
            MergePlayerData(target[key], value, debug)
        else
            if not debug then
                if target[key] == nil then
                    print(('^2[INFO]^0 Added new data field: %s = %s'):format(key, tostring(value)))
                elseif target[key] ~= value then
                    print(('^3[INFO]^0 Updated data field: %s = %s'):format(key, tostring(value)))
                end
            end
            target[key] = (target[key] == nil or target[key] == '') and value or target[key]
        end
    end
end

-- Player Creation

local function InitializePlayerStateBag(source, playerData)
    local state = Player(source).state
    local defaults = LoadPlayerDefaults()

    for _, key in pairs(GetStateBagKeys('player:' .. source)) do
        if not defaults[key] then
            print(('^1[INFO]^0 Removed outdated data field: %s'):format(key))
        end
        state:set(key, nil, true)
    end

    MergePlayerData(playerData, defaults)

    local function populatePlayerState(data, prefix)
        for key, value in pairs(data) do
            if type(value) == 'table' then
                populatePlayerState(value, prefix .. key .. ':')
            else
                state:set(prefix .. key, value, true)
            end
        end
    end

    populatePlayerState(playerData, '')
end

function QBCore.Player.Login(source, citizenid, newData)
    if not source or source == '' then
        QBCore.ShowError(resourceName, 'ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!')
        return false
    end

    if citizenid then
        local license = QBCore.Functions.GetIdentifier(source, 'license')
        local data = MySQL.prepare.await('SELECT * FROM players WHERE citizenid = ?', { citizenid })

        if not data then
            print('^1[ERROR]^0 Failed to load data for Citizen ID:', citizenid)
            DropPlayer(source, 'Failed to load your character data. Please contact staff.')
            return false
        end

        if data and license == data.license then
            local success, playerData = pcall(function()
                return {
                    money = json.decode(data.money) or {},
                    job = json.decode(data.job) or {},
                    gang = json.decode(data.gang) or {},
                    position = json.decode(data.position) or {},
                    metadata = json.decode(data.metadata) or {},
                    charinfo = json.decode(data.charinfo) or {}
                }
            end)

            if not success then
                print('^1[ERROR]^0 Failed to decode player data for Citizen ID:', citizenid)
                DropPlayer(source, 'Failed to decode your character data. Please contact staff.')
                return false
            end

            InitializePlayerStateBag(source, playerData)
        else
            DropPlayer(source, Lang:t('info.exploit_dropped'))
            TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' Has Been Dropped For Character Joining Exploit', false)
        end
    else
        InitializePlayerStateBag(source, newData or {})
    end

    return true
end

function QBCore.Player.CreatePlayer(PlayerData, Offline)
    local self = {}
    self.Offline = Offline
    self.Functions = {}

    function self.Functions.Notify(text, type, length)
        TriggerClientEvent('QBCore:Notify', PlayerData.source, text, type, length)
    end

    function self.Functions.AddMethod(methodName, handler)
        self.Functions[methodName] = handler
    end

    function self.Functions.AddField(fieldName, data)
        self[fieldName] = data
        local state = Player(PlayerData.source).state
        state:set(fieldName, data, true)
    end

    local function CreateDynamicGetSet(prefix)
        return {
            Get = function(key)
                local state = Player(PlayerData.source).state
                return state[prefix .. key] or nil
            end,

            Set = function(key, value)
                local state = Player(PlayerData.source).state
                state:set(prefix .. key, value, true)
                return true
            end
        }
    end

    local function CreateDynamicIncremental(prefix)
        return {
            Get = function(key)
                local state = Player(PlayerData.source).state
                return state[prefix .. key] or 0
            end,

            Set = function(key, value)
                local state = Player(PlayerData.source).state
                state:set(prefix .. key, value, true)
                return true
            end,

            Add = function(key, value)
                local state = Player(PlayerData.source).state
                local currentValue = state[prefix .. key] or 0
                state:set(prefix .. key, currentValue + value, true)
                return true
            end,

            Remove = function(key, value)
                local state = Player(PlayerData.source).state
                local currentValue = state[prefix .. key] or 0
                if currentValue < value then return false end
                state:set(prefix .. key, currentValue - value, true)
                return true
            end
        }
    end

    self.Metadata = CreateDynamicGetSet('metadata:')
    self.Job = CreateDynamicGetSet('job:')
    self.Gang = CreateDynamicGetSet('gang:')
    self.Money = CreateDynamicIncremental('money:')
    self.CharInfo = CreateDynamicGetSet('charinfo:')
    self.Position = CreateDynamicGetSet('position:')
    self.PlayerData = CreateLegacyPlayerData(PlayerData)

    if not self.Offline then
        QBCore.Players[PlayerData.source] = self
        QBCore.Player.Save(PlayerData.source)
        TriggerEvent('QBCore:Server:PlayerLoaded', self)
    end

    return self
end

function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData = PlayerData or {}
    local Offline = not source

    if source then
        PlayerData.source = source
        PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(source, 'license')
        PlayerData.name = GetPlayerName(source)
    end

    InitializePlayerStateBag(source, PlayerData)

    return QBCore.Player.CreatePlayer(PlayerData, Offline)
end

local function BuildPlayerSaveData(source)
    local state = Player(source).state

    return {
        citizenid = state['citizenid'],
        money = json.encode(extractData(source, 'money:')),
        metadata = json.encode(extractData(source, 'metadata:')),
        position = json.encode(extractData(source, 'position:')),
        job = json.encode(extractData(source, 'job:')),
        gang = json.encode(extractData(source, 'gang:'))
    }
end

function QBCore.Player.Save(source)
    local saveData = BuildPlayerSaveData(source)

    if not saveData.citizenid or not saveData.license then
        print('^1[ERROR]^0 Skipped saving data for player [%s] due to missing critical data.'):format(GetPlayerName(source))
        return
    end

    MySQL.insert(
        'INSERT INTO players (citizenid, money, metadata, position, job, gang) VALUES (:citizenid, :money, :metadata, :position, :job, :gang) ON DUPLICATE KEY UPDATE money = :money, metadata = :metadata, position = :position, job = :job, gang = :gang',
        saveData
    )

    if GetResourceState('qb-inventory') ~= 'missing' then
        exports['qb-inventory']:SaveInventory(source)
    end

    QBCore.ShowSuccess(resourceName, 'Player ' .. GetPlayerName(source) .. ' data saved successfully.')
end

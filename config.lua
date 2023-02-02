QBConfig = {
    ["MaxPlayers"] = GetConvarInt('sv_maxclients', 48), -- Gets max players from config file, default 48
    ["DefaultSpawn"] = vector4(-1035.71, -2731.87, 12.86, 0.0),
    ["UpdateInterval"] = 5, -- how often to update player data in minutes
    ["StatusInterval"] = 5000, -- how often to check hunger/thirst status in milliseconds
    ["Money"] = {
        ["CurrencySymbol"] = "$",
        ["MoneyTypes"] = { ["cash"] = 500, ["bank"] = 5000, ["crypto"] = 0 }, -- type = startamount - Add or remove money types for your server (for ex. blackmoney = 0), remember once added it will not be removed from the database!
        ["DontAllowMinus"] = { 'cash', 'crypto' }, -- Money that is not allowed going in minus
        ["PayCheckTimeOut"] = 10, -- The time in minutes that it will give the paycheck
        ["PayCheckSociety"] = false, -- If true paycheck will come from the society account that the player is employed at, requires qb-management
    },
    ["Player"] = {
        ["HungerRate"] = 4.2, -- Rate at which hunger goes down.
        ["ThirstRate"] = 3.8, -- Rate at which thirst goes down.
        ["Bloodtypes"] = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"},
    },
    ["Server"] = {
        ["Closed"] = false, -- Set server closed (no one can join except people with ace permission 'qbadmin.join')
        ["ClosedReason"] = "Server Closed", -- Reason message to display when people can't join the server
        ["Uptime"] = 0, -- Time the server has been up.
        ["Whitelist"] = false, -- Enable or disable whitelist on the server
        ["WhitelistPermission"] = 'admin', -- Permission that's able to enter the server when the whitelist is on
        ["PVP"] = true, -- Enable or disable pvp on the server (Ability to shoot other players)
        ["Discord"] = "", -- Discord invite link
        ["CheckDuplicateLicense"] = true, -- Check for duplicate rockstar license on join
        ["Permissions"] = { 'god', 'admin', 'mod' }, -- Add as many groups as you want here after creating them in your server.cfg
    }, -- General server config
    ["Notify"] = {
        ["NotificationStyling"] = {
            ["group"] = false, -- Allow notifications to stack with a badge instead of repeating
            ["position"] = "right", -- top-left | top-right | bottom-left | bottom-right | top | bottom | left | right | center
            ["progress"] = true -- Display Progress Bar
        },
        -- These are how you define different notification variants
        -- The "color" key is background of the notification
        -- The "icon" key is the css-icon code, this project uses `Material Icons` & `Font Awesome`
        ["VariantDefinitions"] = {
            ["success"] = {
                ["classes"] = 'success',
                ["icon"] = 'done'
            },
            ["primary"] = {
                ["classes"] = 'primary',
                ["icon"] = 'info'
            },
            ["error"] = {
                ["classes"] = 'error',
                ["icon"] = 'dangerous'
            },
            ["police"] = {
                ["classes"] = 'police',
                ["icon"] = 'local_police'
            },
            ["ambulance"] = {
                ["classes"] = 'ambulance',
                ["icon"] = 'fas fa-ambulance'
            }
        }
    }
}
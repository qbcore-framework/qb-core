QBConfig = {}

QBConfig.MaxPlayers = GetConvarInt('sv_maxclients', 48) -- Gets max players from config file, default 48
QBConfig.ServerName = GetConvar('sv_hostname')
QBConfig.DefaultSpawn = vector4(-1035.71, -2731.87, 12.86, 0.0)
QBConfig.UpdateInterval = 5 -- how often to update player data in minutes
QBConfig.StatusInterval = 5000 -- how often to check hunger/thirst status in milliseconds

QBConfig.Money = {}
QBConfig.Money.MoneyTypes = { cash = 500, bank = 5000, crypto = 0 } -- type = startamount - Add or remove money types for your server (for ex. blackmoney = 0), remember once added it will not be removed from the database!
QBConfig.Money.DontAllowMinus = { 'cash', 'crypto' } -- Money that is not allowed going in minus
QBConfig.Money.PayCheckTimeOut = 10 -- The time in minutes that it will give the paycheck
QBConfig.Money.PayCheckSociety = false -- If true paycheck will come from the society account that the player is employed at, requires qb-management

QBConfig.Player = {}
QBConfig.Player.HungerRate = 4.2 -- Rate at which hunger goes down.
QBConfig.Player.ThirstRate = 3.8 -- Rate at which thirst goes down.
QBConfig.Player.Bloodtypes = {
    "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-",
}

QBConfig.Server = {} -- General server config
QBConfig.Server.Closed = false -- Set server closed (no one can join except people with the QBConfig.Server.ClosedWhiteList permissions)
QBConfig.Server.ClosedWhitelist = { 'god', 'admin', 'mod' }
QBConfig.Server.MaintenanceMode = false -- Used for entering maitenance mode, which is different from server closure.
QBConfig.Server.MaintenanceModePassword = "" -- Password for the server if in maintenance mode
QBConfig.Server.Uptime = 0 -- Time the server has been up.
QBConfig.Server.Whitelist = false -- Enable or disable whitelist on the server
QBConfig.Server.WhitelistPermission = 'admin' -- Permission that's able to enter the server when the whitelist is on
QBConfig.Server.PVP = true -- Enable or disable pvp on the server (Ability to shoot other players)
QBConfig.Server.Discord = "" -- Discord invite link
QBConfig.Server.CheckDuplicateLicense = true -- Check for duplicate rockstar license on join
QBConfig.Server.Permissions = { 'god', 'admin', 'mod' } -- Add as many groups as you want here after creating them in your server.cfg

QBConfig.Server.Password = {} -- General server password config
QBConfig.Server.Password.Required = false -- Toggles Server Passwords
QBConfig.Server.Password.String = "" -- Password for the server by default
QBConfig.Server.Password.Attempts = {} -- Used for keeping track of password attempts per client
QBConfig.Server.Password.Card = { -- AdapativeCard for Display of the password input (Don't touch unless you know what you're doing)
    ["type"] = "AdaptiveCard",
    ["minHeight"] = "100px",
    ["backgroundImage"] = "https://i.imgur.com/pMBUwBd.png",
    ["body"] = {
        {
            ["type"] = "Container",
            ["width"] = "stretch",
            ["items"] = {
                {
                    ["type"] = "TextBlock",
                    ["horizontalAlignment"] = "left",
                    ["text"] = "" -- password_header_normal or password_header_maintenance
                },
                {
                    ["type"] = "Input.Text",
                    ["id"] = "password",
                    ["placeholder"] = "" -- password_prompt
                },
                {
                    ["type"] = "Container",
                    ["isVisible"] = false,
                    ["items"] = {
                        {
                            ["type"] = "TextBlock",
                            ["weight"] = "Bolder",
                            ["color"] = "Attention",
                            ["text"] = "" -- password_error_attempts
                        }
                    }
                }
            }
        }
    },
    ["actions"] = {
        {
            ["type"] = "Action.Submit",
            ["title"] = "", -- password_submit
            ["style"] = "positive"
        }
    },
    ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
    ["version"] = "1.2"
}

QBConfig.Notify = {}

QBConfig.Notify.NotificationStyling = {
    group = false, -- Allow notifications to stack with a badge instead of repeating
    position = "right", -- top-left | top-right | bottom-left | bottom-right | top | bottom | left | right | center
    progress = true -- Display Progress Bar
}

-- These are how you define different notification variants
-- The "color" key is background of the notification
-- The "icon" key is the css-icon code, this project uses `Material Icons` & `Font Awesome`
QBConfig.Notify.VariantDefinitions = {
    success = {
        classes = 'success',
        icon = 'done'
    },
    primary = {
        classes = 'primary',
        icon = 'info'
    },
    error = {
        classes = 'error',
        icon = 'dangerous'
    },
    police = {
        classes = 'police',
        icon = 'local_police'
    },
    ambulance = {
        classes = 'ambulance',
        icon = 'fas fa-ambulance'
    }
}
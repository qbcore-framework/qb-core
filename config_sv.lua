QBConfig.Server = {} -- General server config
QBConfig.Server.Name = GetConvar('sv_hostname')
QBConfig.Server.Closed = false -- Set server closed (no one can join except people with the QBConfig.Server.ClosedWhiteList permissions)
QBConfig.Server.ClosedWhitelist = { 'god', 'admin', 'mod' } -- Permission types that are allowed to join the server if it's closed
QBConfig.Server.MaintenanceMode = false -- Used for entering maitenance mode, which is different from server closure, as it can be toggled while server is live
QBConfig.Server.MaintenanceModePassword = "" -- Password for the server if in maintenance mode
QBConfig.Server.Uptime = 0 -- Time the server has been up.
QBConfig.Server.Whitelist = false -- Enable or disable whitelist on the server
QBConfig.Server.WhitelistPermission = 'admin' -- Permission that's able to enter the server when the whitelist is on
QBConfig.Server.Discord = "" -- Discord invite link
QBConfig.Server.CheckDuplicateLicense = true -- Check for duplicate rockstar license on join
QBConfig.Server.Permissions = { 'god', 'admin', 'mod' } -- Add as many groups as you want here after creating them in your server.cfg

QBConfig.Server.Password = {} -- General server password config
QBConfig.Server.Password.Required = false -- Toggles Server Passwords
QBConfig.Server.Password.String = "" -- Password for the server by default
QBConfig.Server.Password.Attempts = {} -- Used for keeping track of password attempts per client
QBConfig.Server.Password.AttemptsFailureTime = 5 -- [Minutes] Delay between password attempts after fail, this multiplies by failed attempts, e.g., 2 failed attempts will be 2x this time.
QBConfig.Server.Password.AttemptsFailureMaxBan = 3 -- [Quantity] Quantity of times a client can fail password attempts before permanently banned

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
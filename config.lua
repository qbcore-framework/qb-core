QBConfig = {}

QBConfig.MaxPlayers = GetConvarInt('sv_maxclients', 48) -- Gets max players from config file, default 32
QBConfig.DefaultSpawn = vector4(-1035.71, -2731.87, 12.86, 0.0)

QBConfig.Money = {}
QBConfig.Money.MoneyTypes = {['cash'] = 5000, ['bank'] = 25000, ['crypto'] = 0 } -- ['type']=startamount - Add or remove money types for your server (for ex. ['blackmoney']=0), remember once added it will not be removed from the database!
QBConfig.Money.DontAllowMinus = {'cash', 'crypto'} -- Money that is not allowed going in minus
QBConfig.Money.PayCheckTimeOut = 30 -- The time in minutes that it will give the paycheck

QBConfig.Player = {}
QBConfig.Player.MaxWeight = 120000 -- Max weight a player can carry (currently 120kg, written in grams)
QBConfig.Player.MaxInvSlots = 10 -- Max inventory slots for a player
QBConfig.Player.Bloodtypes = {
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
}

QBConfig.Server = {} -- General server config
QBConfig.Server.closed = false -- Set server closed (no one can join except people with ace permission 'qbadmin.join')
QBConfig.Server.closedReason = "Server Closed" -- Reason message to display when people can't join the server
QBConfig.Server.uptime = 0 -- Time the server has been up.
QBConfig.Server.whitelist = false -- Enable or disable whitelist on the server
QBConfig.Server.discord = "https://discord.gg/g3qqvbJv" -- Discord invite link
QBConfig.Server.PermissionList = {} -- permission list

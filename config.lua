QBConfig = {}

QBConfig.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- Gets max players from config file, default 32
QBConfig.DefaultSpawn = vector4(-1035.71, -2731.87, 12.86, 0.0)

QBConfig.Money = {}
QBConfig.Money.MoneyTypes = {['cash'] = 500, ['bank'] = 5000, ['crypto'] = 0} -- ['type']=startamount - Add or remove money types for your server (for ex. ['blackmoney']=0), remember once added it will not be removed from the database!
QBConfig.Money.DontAllowMinus = {'cash', 'crypto'} -- Money that is not allowed going in minus
QBConfig.Money.PayCheckTimeOut = 10 -- The time in minutes that it will give the paycheck

QBConfig.Player = {}
QBConfig.Player.MaxWeight = 120000 -- Max weight a player can carry (currently 120kg, written in grams)
QBConfig.Player.MaxInvSlots = 41 -- Max inventory slots for a player
QBConfig.Player.Bloodtypes = {
	"A+",
	"A-",
	"B+",
	"B-",
	"AB+",
	"AB-",
	"O+",
	"O-"
}
QBConfig.Player.Tables = {
	{table = "players", column = "citizenid"},
	{table = "apartments", column = "citizenid"},
	{table = "bank_accounts", column = "citizenid"},
	{table = "crypto_transactions", column = "citizenid"},
	{table = "phone_invoices", column = "citizenid"},
	{table = "phone_messages", column = "citizenid"},
	{table = "playerskins", column = "citizenid"},
	{table = "player_boats", column = "citizenid"},
	{table = "player_contacts", column = "citizenid"},
	{table = "player_houses", column = "citizenid"},
	{table = "player_mails", column = "citizenid"},
	{table = "player_outfits", column = "citizenid"},
	{table = "player_vehicles", column = "citizenid"},
	{table = "companies", column = "owner"},
	{table = "lapraces", column = "creator"},
	{table = "occasion_vehicles", column = "seller"}
}

QBConfig.Server = {} -- General server config
QBConfig.Server.closed = false -- Set server closed (no one can join except people with ace permission 'qbadmin.join')
QBConfig.Server.closedReason = "Server Closed" -- Reason message to display when people can't join the server
QBConfig.Server.uptime = 0 -- Time the server has been up.
QBConfig.Server.whitelist = false -- Enable or disable whitelist on the server
QBConfig.Server.discord = "" -- Discord invite link
QBConfig.Server.PermissionList = {} -- permission list

fx_version 'cerulean'
game 'gta5'

description 'QB-Core'
version '1.0.0'

client_scripts {
	"config.lua",
	"shared.lua",
	"client/main.lua",
	"client/functions.lua",
	"client/loops.lua",
	"client/events.lua",
	"client/debug.lua"
}

server_scripts {
	"config.lua",
	"shared.lua",
	"server/main.lua",
	"server/functions.lua",
	"server/player.lua",
	"server/events.lua",
	"server/commands.lua",
	"server/debug.lua"
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js'
}

dependencies {
	'progressbar',
	'connectqueue',
	'ghmattimysql'
}

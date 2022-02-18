fx_version 'cerulean'
game 'gta5'

description 'QB-Core'
version '1.1.0'

shared_scripts {
	'shared/locale.lua',
	'locale/en.lua', -- replace with desired language
	'config.lua',
	'shared/main.lua',
	'shared/items.lua',
	'shared/jobs.lua',
	'shared/vehicles.lua',
	'shared/gangs.lua',
	'shared/weapons.lua'
}

client_scripts {
	'client/main.lua',
	'client/functions.lua',
	'client/loops.lua',
	'client/events.lua',
	'client/drawtext.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/functions.lua',
	'server/player.lua',
	'server/events.lua',
	'server/commands.lua',
	'server/exports.lua',
	'server/debug.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/css/style.css',
	'html/css/drawtext.css',
	'html/js/*.js'
}

dependencies {
	'oxmysql',
	'progressbar',
	'connectqueue'
}

lua54 'yes'

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot'
description 'Core resource for the framework, contains all the core functionality and features'
version '2.0.1'

shared_scripts {
    'shared/locale.lua',
    'locale/en.lua',
    'locale/*.lua',
    'shared/core.lua',
    'shared/loader.lua',
    'shared/main.lua'
}

client_scripts {
    'client/functions.lua',
    'client/loops.lua',
    'client/events.lua',
    'client/drawtext.lua',
    'client/editor.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/functions.lua',
    'server/player.lua',
    'server/events.lua',
    'server/commands.lua',
    'server/exports.lua',
    'server/debug.lua',
    'server/editor.lua',
    'server/paychecks.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'shared/config.json',
    'shared/gangs.json',
    'shared/items.json',
    'shared/jobs.json',
    'shared/player_defaults.json',
    'shared/vehicles.json',
    'shared/weapons.json'
}

dependency 'oxmysql'

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot'
description 'Core resource for the framework'
version '2.0.0'

shared_scripts {
    'shared/locale.lua',
    'locale/*.lua',
    'shared/lua/core.lua',
    'shared/lua/loader.lua',
    'shared/lua/functions.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'shared/json/jobs.json',
    'shared/json/gangs.json',
    'shared/json/items.json',
    'shared/json/vehicles.json',
    'shared/json/weapons.json'
}

dependency 'oxmysql'

-- Rapozillha 
-- + Informações no readme.md

fx_version 'cerulean'
game 'gta5' 

author 'Rapozillha <https://twitch.tv/rapozillha>'
description 'Sistema de XP para craft'
version '1.0.0'

ui_page 'html/ui.html'

client_scripts{
    'config.lua',
    'client/notifications.lua',
    'client/craft.lua', -- Isto é só para a parte do craft
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/xp.lua', -- Isto é só para a parte do XP
    'server/craft.lua', -- Isto é só para a parte do craft
}

files {
    'html/ui.html',
    'html/css/main.css',
    'html/js/app.js',
}

export "setCraftingLevel"
export "getCraftingLevel"
export "giveCraftingLevel"
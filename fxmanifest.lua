fx_version 'adamant'

game 'gta5'

author 'BabyDrill'

description 'This is a fishing system :)'

client_scripts {
    "client/client.lua",
    "config.lua"
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "config.lua",
    "server/server.lua"
}
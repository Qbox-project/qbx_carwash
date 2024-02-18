fx_version 'cerulean'
game 'gta5'

description 'QBX_Carwash'
repository 'https://github.com/Qbox-project/qbx_carwash'
version '1.0.0'

ox_lib 'locale'

shared_scripts {
	'@ox_lib/init.lua',
}

server_script 'server/main.lua'
client_scripts {
    '@qbx_core/modules/lib.lua',
    'client/main.lua'
}

files {
    'locales/*.json',
    'config/client.lua',
    'config/shared.lua',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
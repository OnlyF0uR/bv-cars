fx_version 'cerulean'
game 'gta5'

shared_script 'config.lua'
server_scripts {
	'server/main.lua',
	'server/utils.lua',
}
client_script 'client/main.lua'

ui_page 'html/index.html'
files {
	'html/index.html',
  'html/style.css',
	'html/script.js'
}

dependencies {
	'bv-core',
	'mythic_notify',
	'oxmysql',
}

exports {
	'GeneratPlate',
	'GetCarClass',
	'HasHarness'
}
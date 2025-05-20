fx_version 'cerulean'
game 'gta5'

shared_script 'config.lua'
server_script 'server/main.lua'
client_scripts {
	'client/utils.lua',
	'client/main.lua'
}

ui_page 'html/index.html'
files {
	'html/index.html',
    'html/style.css',
	'html/script.js'
}

dependencies {
	'fu_core'
}

exports {
	'GeneratePlate',
	'GetCarClass',
	'HasHarness'
}
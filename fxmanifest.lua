fx_version "bodacious"
game "gta5"

ui_page "dist/index.html"

shared_script {
    "@vrp/lib/utils.lua"
}

client_script {
    "client.lua"
}

server_script {
    "server.lua"
}

files {
    "dist/*",
    "dist/assets/*",
    "dist/assets/media/*"
}
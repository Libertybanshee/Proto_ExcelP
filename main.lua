-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local image = {}

local frame = 1

function love.load()
    for n = 1, 17 do
        image[n] = love.graphics.newImage("walk" .. n .. "png")
    end
end

function love.update(dt)
end

function love.draw()
end

function love.keypressed(key)
end

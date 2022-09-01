-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local image = {}
local frame = 1
local animations = {}
local x = 10
local reverse = 1

local animStates = {
    run = 1,
    stand = 2,
    jump = 3
}

animations[animStates.run] = {
    first = 1,
    last = 6,
    speed = 6,
    loop = true
}

animations[animStates.stand] = {
    first = 7,
    last = 8,
    speed = 1,
    loop = true
}

animations[animStates.jump] = {
    first = 9,
    last = 11,
    speed = 3,
    loop = false
}

local currentAnimation = 0

function changeAnimation(pAnim)
    if currentAnimation ~= pAnim then
        currentAnimation = pAnim
        frame = animations[currentAnimation].first
    end
end

function UpdateAnimation(dt)
    frame = frame + dt * animations[currentAnimation].speed
    if frame >= animations[currentAnimation].last + 1 then 
        if animations[currentAnimation].loop then
            frame = animations[currentAnimation].first
        else
            frame = animations[currentAnimation].last
        end
    end
end

function love.load()
    for n = 1, 11 do
        image[n] = love.graphics.newImage("img/sprite" .. n .. ".png")
    end
    changeAnimation(animStates.stand)
end

function love.update(dt)
    UpdateAnimation(dt)
    if love.keyboard.isDown("d") then
        reverse = 1
        x = x + dt * 40
        changeAnimation(animStates.run)
    elseif love.keyboard.isDown("q") then
        reverse = -1
        x = x + dt * -40
        changeAnimation(animStates.run)
    else
        changeAnimation(animStates.stand)
    end
end

function love.draw()
    love.graphics.scale(3, 3)
    love.graphics.draw(image[math.floor(frame)], x, 50, 0, reverse, 1)
    love.graphics.print("frame : " .. tostring(math.floor(frame)), x, 30)
end

function love.keypressed(key)
    print(key)
end

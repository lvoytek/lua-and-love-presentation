local moonshine = require("moonshine")

local whale
local rainbowShader, fogShader
local time = 0

local useFog = false

function love.load()
	love.window.setMode(800, 600, {resizable=true, minwidth=400, minheight=300})
	love.window.setTitle("Scale Image")

	whale = love.graphics.newImage("whale.png")
    rainbowShader = love.graphics.newShader("rainbow-ripple.glsl")

	fogShader = moonshine(moonshine.effects.fog)
	fogShader.fog.fog_color = {.1, .05, 0}
	fogShader.fog.speed = {.6, .9}
end

function love.update(dt)
    time = time + dt
    rainbowShader:send("time", time)
    fogShader.fog.time = time
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
       useFog = not useFog
    end
 end

function love.draw()
	local width, height = love.graphics.getDimensions()
	local scaleX = width / whale:getWidth()
	local scaleY = height / whale:getHeight()

    if useFog then
        love.graphics.draw(whale, 0, 0, 0, scaleX, scaleY)
        fogShader(function() end)
    else
        love.graphics.setShader(rainbowShader)
        love.graphics.draw(whale, 0, 0, 0, scaleX, scaleY)
        love.graphics.setShader()
    end
end

function love.load()
	love.window.setMode(800, 600, {resizable=true, minwidth=800, minheight=600})
	love.window.setTitle("System Info")

	ubuntuFont = love.graphics.newFont("font/Ubuntu-L.ttf", 80)
	love.graphics.setFont(ubuntuFont)
end

function love.draw()
	love.graphics.print("OS: " .. love.system.getOS(), 50, 50)
	love.graphics.print("Power: " .. love.system.getPowerInfo(), 50, 150)
	love.graphics.print("Threads: " .. love.system.getProcessorCount(), 50, 250)
	love.graphics.print("FPS: " .. love.timer.getFPS(), 50, 350)
	love.graphics.print("Time Elapsed: " .. math.floor(love.timer.getTime()) .. "s", 50, 450)
end

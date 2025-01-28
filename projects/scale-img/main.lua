function love.load()
	love.window.setMode(800, 600, {resizable=true, minwidth=400, minheight=300})
	love.window.setTitle("Scale Image")

	whale = love.graphics.newImage("whale.png")
end

function love.draw()
	local width, height = love.graphics.getDimensions()
	local scaleX = width / whale:getWidth()
	local scaleY = height / whale:getHeight()
	love.graphics.draw(whale, 0, 0, 0, scaleX, scaleY)
end

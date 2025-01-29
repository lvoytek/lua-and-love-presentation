function love.load()
	-- Constants
	whaleRadius = 50
	lvSize = 100
	gravity = 9.81
	meterSize = 64

	-- Window setup
	love.window.setMode(1000, 800, {resizable=false})
	love.window.setTitle("Drag Objects")

	-- Physics world initialization
	love.physics.setMeter(meterSize)
    world = love.physics.newWorld(0, gravity * meterSize, true)

	-- Draggable Whale Sprite
	whale = {}
	whale.image = love.graphics.newImage("gfx/whale.png")
	whale.scaleX = whaleRadius * 2 / whale.image:getWidth()
	whale.scaleY = whaleRadius * 2 / whale.image:getHeight()
	whale.body = love.physics.newBody(world, 500, 400, "dynamic")
	whale.shape = love.physics.newCircleShape(whaleRadius)
	whale.fixture = love.physics.newFixture(whale.body, whale.shape)

	-- Draggable lv Logo
	lv = {}
	lv.image = love.graphics.newImage("gfx/lv.png")
	lv.scale = lvSize / lv.image:getWidth()
	lv.body = love.physics.newBody(world, 200, 600, "dynamic")
	lv.shape = love.physics.newRectangleShape(lvSize, lvSize)
	lv.fixture = love.physics.newFixture(lv.body, lv.shape)

	-- Ground Rectangle
    ground = {}
    ground.body = love.physics.newBody(world, love.graphics.getWidth()/2, love.graphics.getHeight()-50)
    ground.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 100)
    ground.fixture = love.physics.newFixture(ground.body, ground.shape)

	-- State Variables
	dragging = false
	whaleMouseJoint = nil
	lvMouseJoint = nil
end

function love.mousepressed(x, y, button)
	-- Create a physics joint when left click pressed over object
    if button == 1 then
		-- Check if clicking on the whale
        local distance = math.sqrt((x - whale.body:getX())^2 + (y - whale.body:getY())^2)
        if distance < whaleRadius then
            dragging = true
            whaleMouseJoint = love.physics.newMouseJoint(whale.body, x, y)
        end

		-- Check if clicking on lv
		local isInX = (lv.body:getX() + lvSize/2) >= x and x >= (lv.body:getX() - lvSize/2)
		local isInY = (lv.body:getY() + lvSize/2) >= y and y >= (lv.body:getY() - lvSize/2)
		if isInY and isInX then
			dragging = true
			lvMouseJoint = love.physics.newMouseJoint(lv.body, x, y)
		end
    end
end

function love.mousemoved(x, y, dx, dy)
    if dragging then
		if whaleMouseJoint then
        	whaleMouseJoint:setTarget(x, y)
    	end

		if lvMouseJoint then
        	lvMouseJoint:setTarget(x, y)
    	end
	end
end

function love.mousereleased(x, y, button)
	-- Remove physics when the object is released
    if button == 1 then 
		if whaleMouseJoint then
        	whaleMouseJoint:destroy()
        	whaleMouseJoint = nil
		end

		if lvMouseJoint then
        	lvMouseJoint:destroy()
        	lvMouseJoint = nil
		end

        dragging = false
    end
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	love.graphics.setColor(0.1, 0.7, 0.1)
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(whale.image, whale.body:getX(), whale.body:getY(), whale.body:getAngle(), whale.scaleX, whale.scaleY, whale.image:getWidth()/2, whale.image:getHeight()/2)
	love.graphics.draw(lv.image, lv.body:getX(), lv.body:getY(), lv.body:getAngle(), lv.scale, lv.scale, lv.image:getWidth()/2, lv.image:getHeight()/2)
end

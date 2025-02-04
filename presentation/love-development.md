## Using LÖVE's Libraries


### Hello World

```lua [1-3|1|2]
function love.draw()
	love.graphics.print("Hello World", 400, 300)
end
```


### Images and Windows

```lua [1-13|1-6|2-3|5|8-13|9|10-11|12]
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
```


### System Information

```lua [1-15|5-6|10-14|14]
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
```


### Physics
#### Initialization

```lua [1-26|2-4|8-9|13-20|24-25]
function love.load()
	gravity = 9.81
	meterSize = 64
	whaleRadius = 50

	...

	love.physics.setMeter(meterSize)
    world = love.physics.newWorld(0, gravity * meterSize, true)

	...

	whale = {}
	whale.image = love.graphics.newImage("gfx/whale.png")
	whale.scaleX = whaleRadius * 2 / whale.image:getWidth()
	whale.scaleY = whaleRadius * 2 / whale.image:getHeight()
	whale.body = love.physics.newBody(world, 500, 400, "dynamic")
	whale.shape = love.physics.newCircleShape(whaleRadius)
	whale.fixture = love.physics.newFixture(whale.body, whale.shape)
	whale.fixture:setRestitution(0.5)

	...

	dragging = false
	whaleMouseJoint = nil
end
```


### Physics
#### Mouse and Joints

```lua [1-9|1-2|3-4|5-6|11-15|11|13|17-23|19-20]
function love.mousepressed(x, y, button)
    if button == 1 then
        local distance = math.sqrt((x - whale.body:getX())^2 + (y - whale.body:getY())^2)
        if distance < whaleRadius then
            dragging = true
            whaleMouseJoint = love.physics.newMouseJoint(whale.body, x, y)
        end
    end
end

function love.mousemoved(x, y, dx, dy)
    if dragging and whaleMouseJoint then
		whaleMouseJoint:setTarget(x, y)
	end
end

function love.mousereleased(x, y, button)
    if button == 1 and whaleMouseJoint then
        whaleMouseJoint:destroy()
        whaleMouseJoint = nil
        dragging = false
    end
end
```


### Physics
#### Updating

```lua [1-3|6-7|9-10]
function love.update(dt)
	world:update(dt)
end

function love.draw()
	love.graphics.setColor(0.1, 0.7, 0.1)
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(whale.image, whale.body:getX(), whale.body:getY(), whale.body:getAngle(), whale.scaleX, whale.scaleY, whale.image:getWidth()/2, whale.image:getHeight()/2)
end
```


### Shaders

```lua
local whale
local rainbowShader
local time = 0

function love.load()
	love.window.setMode(800, 600, {resizable=true, minwidth=400, minheight=300})
	love.window.setTitle("Scale Image")

	whale = love.graphics.newImage("whale.png")
	rainbowShader = love.graphics.newShader("rainbow-ripple.glsl")
end

function love.update(dt)
	time = time + dt
	rainbowShader:send("time", time)
end

function love.draw()
	local width, height = love.graphics.getDimensions()
	local scaleX = width / whale:getWidth()
	local scaleY = height / whale:getHeight()

	love.graphics.setShader(rainbowShader)
	love.graphics.draw(whale, 0, 0, 0, scaleX, scaleY)
	love.graphics.setShader()
end
```


### Shaders
```cpp
#pragma language glsl3

extern float time;

vec3 hsv2rgb(float h, float s, float v) {
    vec3 c = vec3(h, s, v);
    vec4 k = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + k.xyz) * 6.0 - k.www);
    return c.z * mix(k.xxx, clamp(p - k.xxx, 0.0, 1.0), c.y);
}

vec2 ripple(vec2 uv, float time) {
    float dist = length(uv - 0.5);
    float angle = atan(uv.y - 0.5, uv.x - 0.5);
    float wave = sin(dist * 20.0 - time * 5.0) * 0.03;
    return uv + vec2(cos(angle), sin(angle)) * wave;
}

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords) {
    uv = ripple(uv, time);
    float hue = fract(uv.x + time * 0.1);
    vec3 col = hsv2rgb(hue, 1.0, 1.0);

    vec4 texColor = texture2D(texture, uv);
    vec4 rainbowColor = vec4(col, 0.5);

    return mix(texColor, rainbowColor, 0.5);
}
```


### Shaders
#### More Resources

- [learnopengl.com](https://learnopengl.com/Getting-started/Shaders)
- [The Book of Shaders](https://thebookofshaders.com/)
- [Moonshine - Repository of LÖVE Shaders](https://github.com/vrld/moonshine)

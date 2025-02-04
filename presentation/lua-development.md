## Developing with Lua


### Lua Syntax
#### Reserved Tokens

    and       break     do        else      elseif    end
    false     for       function  goto      if        in
    local     nil       not       or        repeat    return
    then      true      until     while

    +     -     *     /     %     ^     #
    &     ~     |     <<    >>    //
    ==    ~=    <=    >=    <     >     =
    (     )     {     }     [     ]     ::
    ;     :     ,     .     ..    ...


### Lua Syntax
#### Types

```lua [1-5|1|2-3|4|5]
noValue = nil -- nil
x = 10       -- number
y = 3.1415   -- number
name = "Lua" -- string
isTrue = true -- boolean
```


### Lua Syntax
#### Types

- No explicit type declaration
  - Values determine type, not variables
- nil is falsy
- Numbers internally represented as 64-bit int or float
  - Automatic conversion
  - Can be built as 32-bit through `LUA_32BITS` macro
- Strings are arbitrary immutable byte sequences


### Lua Syntax
#### Advanced Types - Table

```lua [1-6|1-4|6]
local person = {
    name = "Alice",
    age = 25
}

print(person.name)
```


### Lua Syntax
#### Advanced Types - Function

```lua [1-6|1-3|5]
function add(a, b)
    return a + b
end

local sum = add(3, 5)
print(sum)
```


### Lua Syntax
#### Advanced Types - Function

```lua [1-10|1-3|5-7|9|10]
local greet = function(name)
    return "Hello, " .. name
end

local function getGreetingFunction()
    return greet
end

local greetingFunction = getGreetingFunction()
print(greetingFunction("Alice"))
```


### Lua Syntax
#### Advanced Types - Coroutine/Thread

```lua [1-10|1-6|4|8]
co = coroutine.create(function ()
	for i = 1, 3 do
		print("Coroutine step", i)
		coroutine.yield()
	end
end)

coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
```


### Lua Syntax
#### Advanced Types - Userdata

- Used for direct interaction with C libraries
- See [Userdata in Programming in Lua](https://www.lua.org/pil/28.1.html)


### Lua Syntax
#### If Statements

```lua [2-8|2|4|6]
x = 10
if x > 10 then
	print("x is greater than 10")
elseif x == 10 then
	print("x is 10")
else
	print("x is less than 10")
end
```


### Lua Syntax
#### Loops

<div style="display: flex; gap: 20px;">
<div style="flex: 1; text-align: center;">

#### While Loop

```lua
count = 0
while count < 5 do
	print(count)
	count = count + 1
end
```

</div>
<div style="flex: 1; text-align: center;">

#### For Loop

```lua
for i = 1, 5 do
	print(i)
end
```

</div>


### Lua Functionality
#### Indexing

```lua
	a = {} -- new array
	for i=1, 1000 do
    	a[i] = 0
	end
```

- Arrays are just tables with integer indecies
- However, convention states the first index is 1


### Lua Functionality
#### Environments

```lua
x = 10 --global

function test(a)
	local hi = "Hello" --local to function

	if a == 1 then
		local y = 2 --local to if statement
		b = 10 --global
	end

	local x = 5 --local - overrides global
end
```

- Global and Local scope
- Global by default


### Lua Functionality
#### Garbage Collection

- Automatic memory management, based on variable scope
- Incremental and Generational Options
- See [Dev Docs Garbage Collection](https://devdocs.io/lua~5.4/index#2.5)


### More info

- [Lua 5.4 Dev Docs](https://devdocs.io/lua~5.4/)
- [Programming in Lua](https://www.lua.org/pil/)
- [Arrays in Lua](https://www.lua.org/pil/11.1.html)

## Developing with Lua


### Lua Syntax
#### Reserved Tokens

- `nil` instead of `null`


### Lua Syntax
#### Types

```lua
noValue = nil -- nil
x = 10       -- number
y = 3.1415   -- number
name = "Lua" -- string
isTrue = true -- boolean
```
- No explicit type declaration
  - Values determine type, not variables
- nil is falsy
- Numbers internally represented as 64-bit int or float
  - Automatic conversion
  - Can be built as 32-bit through `LUA_32BITS` macro
- Strings are arbitrary immutable byte sequences


### Lua Syntax
#### Advanced Types


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


### Lua Syntax
#### Functions


### Lua Functionality
#### Coroutines


### Lua Functionality
#### Indexing


### Lua Functionality
#### Environments


### Lua Functionality
#### Garbage Collection


### Run Lua
#### From a File

<div class="r-hstack">
  <img src="image.png" alt="Image" style="width: 40%;">
  <p>This is some text next to the image.</p>
</div>


### Run Lua
#### With the Live Interpreter


### Run Lua
#### Within C and C++
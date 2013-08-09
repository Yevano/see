--@native string
--@native tostring
--@native rawget
--@native rawset

--@import see.base.Array
--@import see.base.System
--@import see.util.ArgumentUtils

--[[
	A mutable, Array-backed string. Faster and more memory efficient than native strings.
]]

--[[
	Casts a value to a String.
	@param any:value The value to be casted.
]]
function String.__cast(value)
	local type = typeof(value)
	if typeof(type) == "table" and value.__type then
		return value:toString()
	end

	local str = tostring(value)
	local ret = String.new()

	for i = 1, #str do
		ret.charArray[i] = str:sub(i, i):byte()
	end

	return ret
end

--[[
	Constructs a new String which copies the given string.
	@param strings:str... The strings to be copied.
]]
function String:init(...)
	local args = {...}
	self.charArray = Array.new()

	for i = 1, #args do
		local str = cast(args[i], String)
		if not str then return end
		if typeof(str) == "string" then
			for i = 1, #str do
				self.charArray:add(str:sub(i, i):byte())
			end
		elseif typeof(str) == String then
			for i = 1, str:length() do
				self.charArray:add(str.charArray[i])
			end
		end
	end
end

local oldindex = String.__meta.__index

function String.__meta:__index(index)
	if typeof(index) == "number" then
		return self.charArray[index]
	end
	return oldindex[index]
end

function String.__meta:__newindex(index, value)
	if typeof(index) == "number" then
		if typeof(value) == "string" then
			value = string.byte(value)
		end
		self.charArray[index] = value
		return
	end
	rawset(self, index, value)
end

--[[
	Gets a Lua string from this String.
	@return string The Lua string.
]]
function String:lstr()
	local str = ""
	for i = 1, self.charArray.length do
		str = str .. string.char(self.charArray[i])
	end
	return str
end

--[[
	Gets the length of this String.
	@return number The length of this String.
]]
function String:length()
	return self.charArray.length
end

function String.concat(a, b)
	a = cast(a, String)
	b = cast(b, String)
	local ret = String.new(a)
	local len = a:length()
	for i = 1, b:length() do
		ret.charArray[i + len] = b.charArray[i]
	end
	return ret
end

function String.__meta.__concat(a, b)
	return a:concat(b)
end

--[[
	Gets a substring of this String.
	@param number:a Start index.
	@param number:b End index. Defaults to the length of this String.
	@return see.base.String A substring of this String.
]]
function String:sub(a, b)
	if not b then b = self:length() end


end

function String:toString()
	return self
end
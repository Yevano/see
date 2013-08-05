--@native string
--@native tostring
--@import see.base.Array
--@import see.base.System

--[[
	A mutable, Array-backed string. Faster and more memory efficient than native strings.
]]

--[[
	Casts a value to a String.
	@param any:value The value to be casted.
]]
function String.__cast(value)
	local type = typeof(value)
	if typeof(type) == "table" then
		return value:toString()
	end
	return String.new(tostring(value))
end

--[[
	Constructs a new String which copies the given string.
	@param string:str The string to be copied.
]]
function String:init(str)
	self.charArray = Array.new()
	if not str then return end
	if typeof(str) == "string" then
		for i = 1, #str do
			self.charArray[i] = str:sub(i, i):byte()
		end
	elseif typeof(str) == String then
		for i = 1, str:length() do
			self.charArray[i] = str.charArray[i]
		end
	end
end

--[[
	Gets a Lua string from this String.
	@return string The Lua string.
]]
function String:lstr()
	local str = ""
	for i = 1, self.charArray.length do
		str = str .. string.char(self.charArray:get(i))
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

function String:concat(str)
	local ret = String.new(self)
	local len = self:length()
	for i = 1, str:length() do
		ret.charArray[i + len] = str.charArray[i]
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

	-- TODO
end

function String:toString()
	return self
end
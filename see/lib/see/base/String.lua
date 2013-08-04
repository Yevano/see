--@native string

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
	Constructs a new String which copies the given luaString.
	@param string:luaString The string to be copied.
]]
function String:init(luaString)
	self.charArray = Array.new()
	if not luaString then return end
	for i = 1, #luaString do
		self.charArray[i] = luaString:sub(i, i):byte()
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

--[[
	Gets a substring of this String.
	@param number:a Start index.
	@param number:b End index. Defaults to the length of this String.
	@return see.base.String A substring of this String.
]]
function String:sub(a, b)
	
end
--@native bit

--@import see.io.InputStream

--@extends see.io.InputStream

--[[
	An InputStream for doing more advanced operations on other InputStreams.
]]

--[[
	Wraps arounds a see.io.InputStream.
	@param see.io.InputStream:wrap The InputStream to wrap around.
]]
function DataInputStream:init(wrap)
	self.wrap = wrap
end

function DataInputStream:read()
	return self.wrap:read()
end

--[[
	Reads an integer with the given amount of bytes.
	@param number:bytes The number of bytes to encode the number with.
	@return number The integer that was read.
]]
function DataInputStream:readInt(bytes)
	local ret = 0
	local b
	for i = bytes, 1, -1 do
		b = self:read()
		ret = bit.bor(ret, bit.blshift(b, (i - 1) * 8))
	end
	return ret
end

--[[
	Reads a string of a specific length.
	@param number:len The length of the string to read.
	@return see.base.String The string that was read.
]]
function DataInputStream:readString(len)
	local ret = String.new()
	for i = 1, len do
		ret[i] = self:read()
	end
	return ret
end

function DataInputStream:flush()
	self.wrap:flush()
end

function DataInputStream:close()
	self.wrap:close()
end
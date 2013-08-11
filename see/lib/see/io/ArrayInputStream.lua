--@import see.io.InputStream

--@extends see.io.InputStream

--[[
	Wraps around an array to read from.
	@param Array:wrap The array to wrap around.
]]
function ArrayInputStream:init(wrap)
	self.wrap = wrap
	self.position = 1
end

function ArrayInputStream:read()
	self.position = self.position + 1
	return self.wrap[self.position - 1]
end
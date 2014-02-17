--@import see.io.OutputStream
--@import see.util.ArgumentUtils

--@extends see.io.OutputStream

--[[
    Wraps around an array to write to.
    @param Array:wrap The array to wrap around.
    @throw see.util.InvalidArgumentException if the args are incorrect.
]]
function ArrayOutputStream:init(wrap)
	ArgumentUtils.check(1, wrap, Array)
    self.wrap = wrap
    self.position = 1
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function ArrayOutputStream:write(b)
	ArgumentUtils.check(1, b, "number")
    self.wrap[self.position] = b
    self.position = self.position + 1
end
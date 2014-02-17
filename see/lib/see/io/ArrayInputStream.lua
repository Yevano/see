--@import see.io.InputStream
--@import see.util.ArgumentUtils

--@extends see.io.InputStream

--[[
    Wraps around an array to read from.
    @param Array:wrap The array to wrap around.
    @throw see.util.InvalidArgumentException if the args are incorrect.
]]
function ArrayInputStream:init(wrap)
	ArgumentUtils.check(1, wrap, Array)
    self.wrap = wrap
    self.position = 1
end

function ArrayInputStream:read()
    self.position = self.position + 1
    return self.wrap[self.position - 1]
end
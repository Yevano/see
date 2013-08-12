--@import see.io.OutputStream

--@extends see.io.OutputStream

--[[
    Wraps around an array to write to.
    @param Array:wrap The array to wrap around.
]]
function ArrayOutputStream:init(wrap)
    self.wrap = wrap
    self.position = 1
end

function ArrayOutputStream:write(b)
    self.wrap[self.position] = b
    self.position = self.position + 1
end
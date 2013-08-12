--@import see.io.OutputStream
--@import see.util.Bit

--@extends see.io.OutputStream

--[[
    An OutputStream for doing more advanced operations on other OutputStreams.
]]

--[[
    Wraps arounds a see.io.OutputStream.
    @param see.io.OutputStream:wrap The OutputStream to wrap around.
]]
function DataOutputStream:init(wrap)
    self.wrap = wrap
end

function DataOutputStream:write(b)
    self.wrap:write(b)
end

--[[
    Writes an integer with the given amount of bytes.
    @param number:value The value to write.
    @param number:bytes The number of bytes to encode the number with.
]]
function DataOutputStream:writeInt(value, bytes)
    for i = bytes, 1, -1 do
        self:write(bit.band(0xff, bit.brshift(value, (i - 1) * 8)))
    end
end

--[[
    Writes a string.
    @param see.base.String:str The string to write.
]]
function DataOutputStream:writeString(str)
    str = cast(str, String)
    for i = 1, str:length() do
        self:write(str[i])
    end
end

function DataOutputStream:flush()
    self.wrap:flush()
end

function DataOutputStream:close()
    self.wrap:close()
end
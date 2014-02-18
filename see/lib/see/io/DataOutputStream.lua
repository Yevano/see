--@import see.io.OutputStream
--@import see.util.Math

--@extends see.io.OutputStream

--[[
    Modified float conversions from http://snippets.luacode.org/snippets/IEEE_float_conversion_144.
    Modified integer conversions from http://lua-users.org/wiki/ReadWriteFormat.
]]

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
function DataOutputStream:writeInt(num, width)
    local function _n2b(width, num, rem)
        rem = rem * 256
        if width == 0 then return rem end
        return rem, _n2b(width-1, Math.modf(num/256))
    end
    self:writeString(String.char(_n2b(width-1, Math.modf((num + Math.pow(2, width * 8 - 1))/256))))
end

function DataOutputStream:writeUnsignedInt(num, width)
    local function _n2b(width, num, rem)
        rem = rem * 256
        if width == 0 then return rem end
        return rem, _n2b(width-1, Math.modf(num/256))
    end
    self:writeString(String.char(_n2b(width-1, Math.modf((num)/256))))
end

function DataOutputStream:writeFloat(value)
    local s = value < 0 and 1 or 0
    if Math.abs(value) == 1/0 then
        return s == 1 and "\0\0\0\255" or "\0\0\0\127"
    end
    if value ~= value then
        return "\170\170\170\255"
    end
    local fr, exp = Math.frexp(Math.abs(value))
    exp = exp + 64
    self:writeString(String.char(
        Math.floor(fr*2^24)%256,
        Math.floor(fr*2^16)%256,
        Math.floor(fr*2^8)%256,
        Math.floor(exp)%128+128*s))
end

function DataOutputStream:writeDouble(value)
    local s = value < 0 and 1 or 0
    if Math.abs(value) == 1/0 then
        return s == 1 and "\0\0\0\0\0\0\240\255" or "\0\0\0\0\0\0\240\127"
    end
    if value ~= value then
        return "\170\170\170\170\170\170\250\255"
    end
    local fr, exp = Math.frexp(Math.abs(value))
    fr, exp = fr * 2, exp - 1
    exp = exp + 1023
    self:writeString(String.char(
        Math.floor(fr*2^52)%256,
        Math.floor(fr*2^44)%256,
        Math.floor(fr*2^36)%256,
        Math.floor(fr*2^28)%256,
        Math.floor(fr*2^20)%256,
        Math.floor(fr*2^12)%256,
        Math.floor(fr*2^4)%16+Math.floor(exp)%16*16,
        Math.floor(exp/2^4)%128+128*s))
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
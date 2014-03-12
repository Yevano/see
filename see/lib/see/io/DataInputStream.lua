--@import see.io.InputStream
--@import see.util.Math

--@extends see.io.InputStream

--[[
    Modified float conversions from http://snippets.luacode.org/snippets/IEEE_float_conversion_144.
    Modified integer conversions from http://lua-users.org/wiki/ReadWriteFormat.
]]

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
function DataInputStream:readInt(len)
    local str = self:readString(len)
    local function _b2n(exp, num, digit, ...)
        if not digit then return num end
        return _b2n(exp * 256, num + digit * exp, ...)
    end
    return _b2n(256, str.charArray:unpack()) - Math.pow(2, str:length() * 8 - 1)
end

function DataInputStream:readUnsignedInt(len)
    local str = self:readString(len)
    local function _b2n(exp, num, digit, ...)
        if not digit then return num end
        return _b2n(exp * 256, num + digit * exp, ...)
    end
    return _b2n(256, str.charArray:unpack())
end

function DataInputStream:readFloat()
    local str = self:readString(4)
    local fr = str[1]/2^24 + str[2]/2^16 + str[3]/2^8
    local exp = str[4]%128 - 64
    local s = Math.floor(str[4]/128)
    if exp == 63 then
        return fr == 0 and (1 - 2 * s)/0 or 0/0
    end
    return (1 - 2 * s) * fr * 2^exp
end

function DataInputStream:readDouble()
    local str = self:readString(8)
    local fr = str[1]/2^52 + str[2]/2^44 + str[3]/2^36 + str[4]/2^28 + str[5]/2^20 + str[6]/2^12 + (str[7]%16)/2^4 + 1
    local exp = (str[8]%128) * 16 + Math.floor(str[7]/16) - 1023
    local s = Math.floor(str[8]/128)
    if exp == 1024 then
        return fr == 1 and (1 - 2 * s)/0 or 0/0
    end
    return (1 - 2 * s) * fr * 2^exp
end

--[[
    Reads a string of a specific length.
    @param number:len The length of the string to read.
    @return see.base.String The string that was read.
]]
function DataInputStream:readString(len)
    local ret = String:new()
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
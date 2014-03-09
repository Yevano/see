--@native string
--@native tostring
--@native rawget
--@native rawset
--@native tonumber

--@import see.base.Array
--@import see.base.System
--@import see.util.ArgumentUtils
--@import see.util.Matcher

--[[
    An Array-backed string. Faster and more memory efficient than native strings.
]]

--[[
    Casts a value to a String.
    @param any:value The value to be casted.
    @return see.base.String The casted value.
]]
function String.__cast(value)
    local type = typeof(value)
    if not isprimitive(value) then
        if value.__type == String then
            return value
        end
        return value:toString()
    end

    local str = tostring(value)
    local ret = String:new()

    for i = 1, #str do
        ret.charArray:add(str:sub(i, i):byte())
    end

    return ret
end

--[[
    Converts bytes to a String.
    @param ... The bytes to convert.
    @return see.base.String A string representation of the given bytes.
]]
function String.char(...)
    return String:new(string.char(...))
end

--[[
    Constructs a new String which copies the given string.
    @param strings:str... The strings to be copied.
]]
function String:init(...)
    local args = {...}
    self.charArray = Array:new()

    for i = 1, #args do
        local str = cast(args[i], String)
        if not str then return end
        for i = 1, str:length() do
            self.charArray:add(str[i])
        end
    end
end

function String:opIndex(index)
    if typeof(index) == "number" then
        return self.charArray[index]
    end
end

function String:opNewIndex(index, value)
    if typeof(index) == "number" then
        if typeof(value) == "string" then
            value = string.byte(value)
        end
        self.charArray[index] = value
        return true
    end
    return false
end

--[[
    Gets a Lua string from this String.
    @return string The Lua string.
]]
function String:lstr()
    local str = ""
    for i = 1, self:length() do
        str = str .. string.char(self[i])
    end
    return str
end

--[[
    Gets the length of this String.
    @return number The length of this String.
]]
function String:length()
    return self.charArray:length()
end

function String:opConcat(other)
    return STR(self, other)
end

--[[
    Gets a substring of this String.
    @param number:a Start index.
    @param number:b End index. Defaults to the length of this String.
    @return see.base.String A substring of this String.
]]
function String:sub(a, b)
    if not b then b = self:length() end
    ArgumentUtils.check(1, a, "number")
    ArgumentUtils.check(2, b, "number")

    a = a < 0 and self:length() + a + 1 or a
    b = b < 0 and self:length() + b + 1 or b

    if a > b then a, b = b, a end

    local substring = ""
    for i = a, b do
        substring = substring .. string.char(self[i])
    end
    return String:new(substring)
end

--[[
    Adds a string to this String.
    @param see.base.String:str The string to append.
    @return see.base.String This String.
]]
function String:add(str)
    str = cast(str, String)
    for i = 1, str:length() do
        self.charArray:add(str[i])
    end
    return self
end

--[[
    Inserts a given string into this String at the given index.
    @param number:index The index to insert at.
    @param see.base.String:str The string to insert.
    @return see.base.String This String.
]]
function String:insert(index, str)
    ArgumentUtils.check(1, index, "number")
    str = cast(str, String)
    for i = str:length(), 1, -1 do
        self.charArray:insert(index, str[i])
    end
    return self
end

--[[
    Removes a given amount of characters from this String at the given index.
    @param number:index The index to remove characters from.
    @param number:amount The amount of characters to remove.
    @return see.base.String This String.
]]
function String:remove(index, amount)
    ArgumentUtils.check(1, index, "number")
    ArgumentUtils.check(2, amount, "number")
    for i = 1, amount do
        self.charArray:remove(index)
    end
    return self
end

--[[
    Finds a given substring in this string.
    @param see.base.String:str The string to search for.
    @param number:init The index to start searching from. Defaults to 1.
    @return number The index that the substring occurs.
]]
function String:find(str, init)
    str = cast(str, String)
    if not init then init = 1 end
    ArgumentUtils.check(2, init, "number")

    local j = 1
    for i = init, self:length() do
        if self[i] == str[j] then
            if j == str:length() then
                return i - j + 1
            end
            j = j + 1
        else
            j = 1
        end
    end
end

-- TODO: Reimplement as non-native solution.
--[[
    Formats this String using the native string.format.
    @param native:values... The values to pass to string.format.
    @return see.base.String The formatted string.
]]
function String:format(...)
    return String:new(self:lstr():format(...))
end

--[[
    Replaces all instances of str with rep.
    @param see.base.String:str The string to be replaced.
    @param see.base.String:rep The string to replace with.
    @return see.base.String This String.
]]
function String:replace(str, rep)
    str = cast(str, String)
    rep = cast(rep, String)

    local found = self:find(str)
    while found do
        self:remove(found, str:length()):insert(found, rep)
        found = self:find(str, found + 1)
    end

    return self
end

--[[
    Returns a lower case version of this String.
    @return see.base.String The lower case string.
]]
function String:lower()
    local ret = String:new()
    for i = 1, self:length() do
        if self[i] >= 65 and self[i] <= 90 then
            ret[i] = self[i] + 32
        else
            ret[i] = self[i]
        end
    end
    return ret
end

--[[
    Returns an upper case version of this String.
    @return see.base.String The upper case string.
]]
function String:upper()
    local ret = String:new()
    for i = 1, self:length() do
        if self[i] >= 97 and self[i] <= 122 then
            ret[i] = self[i] - 32
        else
            ret[i] = self[i]
        end
    end
    return ret
end

--[[
    Duplicates this String over n times.
    @param number:n The number of times to duplicate this String.
    @return see.base.String A duplicated String.
]]
function String:duplicate(n)
    ArgumentUtils.check(1, n, "number")
    local ret = String:new()
    for i = 1, n do
        ret:add(self)
    end
    return ret
end

--[[
    Reverses this String.
    @return see.base.String A reversed String.
]]
function String:reverse()
    local ret = String:new()
    for i = self:length(), 1, -1 do
        ret:add(String.char(self[i]))
    end
    return ret
end

--[[
    Splits this String into strings separated by sep.
    @param see.base.String sep The separator.
    @return see.base.Array The split strings.
]]
function String:split(sep)
    local ret = Array:new()
    local matcher = Matcher:new(sep, self)
    local l = 1
    while matcher:find() do
        ret:add(self:sub(l, matcher.left - 1))
        l = matcher.right + 1
    end
    ret:add(self:sub(l, -1))
    return ret
end

function String:trim()
    local ret = String:new()
    for i = 1, self:length() do
        if self[i] ~= STR(' ')[1] and self[i] ~= STR('\n')[1] and self[i] ~= STR('\t')[1] and self[i] ~= STR('\r')[1] then
            ret:add(String.char(self[i]))
        end
    end
    return ret
end

--[[
    Converts this String to a number.
    @return number The converted number.
]]
function String:toNumber()
    return tonumber(self:lstr())
end

function String:equals(other)
    return self:lstr() == cast(other, "string")
end

function String:toString()
    return self
end
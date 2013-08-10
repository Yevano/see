--@native table.remove
--@native table.insert
--@native rawget
--@native rawset
--@native unpack

--@import see.util.ArgumentUtils
--@import see.rt.IndexOutOfBoundsException
--@import see.base.System

--[[
    A table-backed, infinite array.
]]

--[[
    Constructs a new Array.
    @param any... The starting elements in the Array.
]]
function Array:init(...)
    local args = {...}
    self.luaArray = { }
    for i = 1, #args do
        self.luaArray[i] = args[i]
    end
end

local oldindex = Array.__meta.__index

function Array.__meta:__index(index)
    if typeof(index) == "number" then
        return self:get(index)
    end
    return oldindex[index]
end

function Array.__meta:__newindex(index, value)
    if typeof(index) == "number" then
        self:set(index, value)
        return
    end
    rawset(self, index, value)
end

function Array:length()
    return #self.luaArray
end

--[[
    Gets the value of the given index.
    @param table:t The object.
    @param number:index The index to get.
    @return any The value of the given index.
]]
function Array:get(index)
    ArgumentUtils.check(1, index, "number")
    if index < 0 then
        index = self:length() + index + 1
    end
    if index <= self:length() and index > 0 then
        return self.luaArray[index]
    end
    throw(IndexOutOfBoundsException.new(index))
end

--[[
    Sets an index. Do not call directly. Use index operator.
    @param table:t The object.
    @param number:index The index to set.
    @param any:value The value to set the given index to.
]]
function Array:set(index, value)
    ArgumentUtils.check(1, index, "number")
    if index < 0 then
        index = self:length() + index + 1
    end
    if index <= self:length() + 1 and index > 0 then
        self.luaArray[index] = value
        return
    end
    throw(IndexOutOfBoundsException.new(index))
end

--[[
    Appends a value to the end of this Array.
    @param any:value 
]]
function Array:add(value)
    self.luaArray[self:length() + 1] = value
end

--[[
    Removes an index from this Array, sliding elements back if needed.
    @param number:index The index to remove.
    @return any The value at the removed index.
]]
function Array:remove(index)
    ArgumentUtils.check(1, index, "number")
    if index < 0 then
        index = self:length() + index + 1
    end
    if index <= self:length() and index > 0 then
        return table.remove(self.luaArray, index)
    end
    throw(IndexOutOfBoundsException.new(index))
end

--[[
    Inserts a value into this Array at the given index, sliding elements forward if needed.
    @param number:index The index to insert at.
    @param any:value The value to insert.
]]
function Array:insert(index, value)
    ArgumentUtils.check(1, index, "number")
    if index < 0 then
        index = self:length() + index + 1
    end
    if index <= self:length() + 1 and index > 0 then
        return table.insert(self.luaArray, index, value)
    end
    throw(IndexOutOfBoundsException.new(index))
end

function Array:unpack()
    return unpack(self.luaArray)
end

--[[
    Iterate over all the elements in this Array.
    @return function An iterator.
]]
function Array:iAll()
    local i = 0
    local len = self:length()
    return function()
        i = i + 1
        return i <= len and self[i] or nil
    end
end

--[[
    Iterate over the elements in the range given.
    @param number:a Range bound.
    @param number:b Range bound.
    @return function An iterator.
]]
function Array:iRange(a, b)
    ArgumentUtils.check(1, a, "number")
    ArgumentUtils.check(2, b, "number")
    if a > b then a, b = b, a end
    local i = a - 1
    return function()
        i = i + 1
        return i <= b and self[i] or nil
    end
end
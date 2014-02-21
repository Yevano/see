--@native table.remove
--@native table.insert
--@native rawget
--@native rawset
--@native unpack

--@import see.util.ArgumentUtils
--@import see.rt.IndexOutOfBoundsException
--@import see.rt.NoSuchElementException
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

--[[
    Wrap around a Lua table.
    @param table:t Table to wrap around.
    @return see.base.Array Array that wraps around the given table.
]]
function Array.wrap(t)
    ArgumentUtils.check(1, t, "table")
    return Array.new(unpack(t))
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

function Array:removeElement(element)
    local index = self:indexOf(element)
    if not index then
        throw(NoSuchElementException.new(STR("No such element ", cast(element, String), ".")))
    end
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

function Array:indexOf(value)
    for i = 1, self:length() do
        if self[i] == value then
            return i
        end
    end
end

function Array:contains(value)
    for i = 1, self:length() do
        if self[i] == value then
            return true
        end
    end
    return false
end

function Array:reset()
    self.luaArray = { }
end

function Array:unpack()
    return unpack(self.luaArray)
end

function Array:map(mapFunc)
    for i = 1, self:length() do
        self[i] = mapFunc(self[i])
    end
end

function Array:filter(filterFunc)
    local ret = Array.new()
    for i = 1, self:length() do
        local e = self[i]
        if filterFunc(e) then
            ret:add(e)
        end
    end
    return ret
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

    if self:length() == 0 then return function() end end

    if a < 0 then a = self:length() + a + 1 end
    if b < 0 then b = self:length() + b + 1 end

    if a < b then
        local i = a - 1
        return function()
            i = i + 1
            return i <= b and self[i] or nil
        end
    end

    local i = a + 1
    return function()
        i = i - 1
        return i >= b and self[i] or nil
    end
end
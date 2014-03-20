--@import see.util.EmptyStackException

--[[
	Creates a stack
	@param any... The starting elements in the stack
]]
function Stack:init(...)
	local args = { ... }
	self.array = Array:new()
	for i = 1, #args do
		self.array[i] = args[i]
	end
end

function Stack:opIndex(index)
    if typeof(index) == "number" then
        return self:get(index)
    end
end

function Stack:opNewIndex(index, value)
    if typeof(index) == "number" then
        self:set(index, value)
        return true
    end
    return false
end

function Stack:peek()
	if self.array:length() == 0 then
		throw(EmptyStackException:new())
	end
	return self.array:get(self.array:length())
end

function Stack:pop()
	if self.array:length() == 0 then
		throw(EmptyStackException:new())
	end
	local ret = self.array:get(self.array:length())
	self.array:remove(self.array:length())
	return ret
end

function Stack:push(element)
	self.array:add(element)
end

function Stack:set(index, value)
    ArgumentUtils.check(1, index, "number")
    if index < 0 then
        index = self:length() + index + 1
    end
    if index <= self:length() + 1 and index > 0 then
        self.array:set(index, value)
        return
    end
    throw(IndexOutOfBoundsException:new(index))
end

function Stack:indexOf(index)
	return self.array:indexOf(index)
end

function Stack:remove(index)
	self.array:remove(index)
end

function Stack:removeElement(element)
	self.array:removeElement(element)
end

function Stack:length()
    return self.array:length()
end

function Stack:iAll()
	return self.array:iAll()
end

function Stack:iRange(a, b)
	return self.array:iRange(a, b)
end

function Stack:isEmpty()
	return self.array:length() == 0 --nil counts?
end
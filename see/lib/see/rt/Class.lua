--[[
    A wrapper for the runtime class object.
]]

function Class:getName()
    return String.new(self.__name)
end

function Class:toString()
    return self:getName()
end
--@native __rt
--@native rawget
--@native setmetatable

--@import see.base.String

--[[
    The runtime class.
]]

function Class:new(...)
    local instance = setmetatable({ __class = self }, __rt.classMT)
    instance:init(...)
    return instance
end

function Class:getSuper()
    return __rt.classTables[self].__super
end

function Class:getName()
    return String:new(__rt.classTables[self].__name)
end

function Class:toString()
    return self:getName()
end
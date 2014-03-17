--@native __rt
--@native rawget
--@native rawset
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

function Class:isAssignableFrom(class)
	local objectType = self
    while objectType do
        if class == objectType then
            return true
        end
        objectType = objectType:getSuper()
    end
    return false
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
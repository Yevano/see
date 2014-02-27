--@native __rt
--@native print
--@native setmetatable

--[[
    The runtime class.
]]

function Class:new(...)
    local instance = setmetatable({ __class = self }, __rt.classMT)
    instance:init(...)
    return instance
end

function Class:toString()
    return String:new(self.name)
end
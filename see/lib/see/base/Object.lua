--@native tostring
--@native pairs
--@native setmetatable
--@native getmetatable
--@native rawget
--@native __rt
 
--[[
    The super class for all classes loaded in the SEE Runtime.
]]

function Object:super(class)
    local obj = self
    return setmetatable({ }, { __index = function(t, k)
        return function(...)
            return __rt.classTables[class][k](obj, ...)
        end
    end })
end

--[[
    Fully copies an object.
    @return see.base.Object The copied object.
]]
function Object:copy()
    local ret = { }
    for k, v in pairs(self) do
        ret[k] = v
    end
    setmetatable(ret, getmetatable(self))
    return ret
end

--[[
    Return the type of this Object.
    @return table The runtime class.
]]
function Object:getClass()
    return rawget(self, "__class")
end

function Object:instanceof(type)
    local objectType = self:getClass()
    while objectType do
        if type == objectType then
            return true
        end
        objectType = objectType:getSuper()
    end
    return false
end

function Object:toString()
    return STR(self:getClass():getName(), " (", tostring(self):sub(8, -1), ")")
end

--[[function Object:opEq(other)
    return self:equals(other)
end]]

function Object:equals(other)
    return self == other
end
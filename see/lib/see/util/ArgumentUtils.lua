--@import see.rt.InvalidArgumentException

--[[
    Provides utilities for checking arguments in methods.
]]

--[[
    Ensures an argument is of the correct type.
    @param number:n The argument being checked.
    @param any:value The value being checked.
    @param see.rt.Class|see.base.String:type The type to validate for.
]]
function ArgumentUtils.check(n, value, type)
    local actualType = typeof(value)
    if actualType ~= type then
        throw(InvalidArgumentException:new(n, type, actualType))
    end
end
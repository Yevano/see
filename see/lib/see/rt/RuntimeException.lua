--@import see.base.Exception

--@extends see.base.Exception

--[[
    Describes an exception which occurs at runtime.
]]

--[[
    Constructs a new RuntimeException.
    @param string:message The error message.
]]
function RuntimeException:init(message)
    self:super(Exception).init(message)
end
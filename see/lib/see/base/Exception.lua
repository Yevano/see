--@import see.base.Object
--@import see.base.String
--@import see.base.System

--[[
    Describes any error that occurs.
]]

--[[
    Constructs a new Exception.
    @param string:message The error message.
]]
function Exception:init(message)
    message = cast(message, String)
    self.message = message
end
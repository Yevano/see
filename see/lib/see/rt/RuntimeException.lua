--@import see.base.Exception
--@extends see.base.Exception

--[[
	Constructs a new RuntimeException.
	@param string:message The error message.
]]
function RuntimeException:init(message)
	Exception.init(self, message)
end
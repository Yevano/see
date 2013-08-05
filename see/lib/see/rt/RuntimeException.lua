--@extends see.base.Exception

--[[
	Constructs a new RuntimeException.
	@param string:message The error message.
]]
function RuntimeException:init(message)
	message = cast(message, String)
	Exception.init(self, message)
end
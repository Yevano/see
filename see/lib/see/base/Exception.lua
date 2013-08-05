--@import see.base.String

--[[
	Constructs a new Exception.
	@param string:message The error message.
]]
function Exception:init(message)
	message = cast(message, String)
	self.message = message
end
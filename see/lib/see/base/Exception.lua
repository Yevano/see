--@import see.base.String
--@import see.base.System

--[[
	Constructs a new Exception.
	@param string:message The error message.
]]
function Exception:init(message)
	message = cast(message, String)
	self.message = message
end

function Exception:toString()
	return "[" .. self:getClass():getName() .. "]" .. self.message
end
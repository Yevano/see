--@import see.io.Peripheral

--[[
	Wrapper for command block peripherals
	@param see.base.String:what side the command block is on (can be on network as well)
]]
function CommandBlock:init(location)
	if not Peripheral.isPresent(location) then
		throw(InvalidArgumentException:new(1, "see.base.String: location", "invalid location"))
	end

	self.location = location
end

function CommandBlock:getCommand()
	return Peripheral.call(self.location, "getCommand")
end

function CommandBlock:setCommand(command)
	Peripheral.call(self.location, "setCommand", command)
end

function CommandBlock:runCommand()
	Peripheral.call(self.location, "runCommand")
end
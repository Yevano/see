--@import see.io.Peripheral
--@import see.io.peripheral.AbstractPeripheral

--@extends see.io.peripheral.AbstractPeripheral

--[[
	Wrapper for command block peripherals
	@param see.base.String:what side the command block is on (can be on network as well)
]]
function CommandBlock:init(location)
	self:super(AbstractPeripheral).init(location)
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
--@import see.io.Peripheral
--@import see.io.peripheral.AbstractPeripheral

--@extends see.io.peripheral.AbstractPeripheral

--[[
	Wrapper for computer peripherals
	@param see.base.String:what side the computer is on (can be on network as well)
]]
function Computer:init(location)
	self:super(AbstractPeripheral).init(location)
end

function Computer:turnOn()
	Peripheral.call(self.location, "turnOn")
end

function Computer:shutdown()
	Peripheral.call(self.location, "shutdown")
end

function Computer:reboot()
	Peripheral.call(self.location, "reboot")
end

function Computer:getID()
	return Peripheral.call(self.location, "getID")
end
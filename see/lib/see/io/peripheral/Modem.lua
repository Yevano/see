--@import see.io.Peripheral
--@import see.util.ArgumentUtils

--[[
	Wrapper for modem peripherals
	@param see.base.String:what side the modem is on (can be on network as well)
]]
function Modem:init(location)
	if not Peripheral.isPresent(location) then
		throw(InvalidArgumentException:new(1, "see.base.String: location", "invalid location"))
	end

	self.location = location
end

function Modem:isOpen(channel)
	ArgumentUtils.check(1, channel, "number")
	return Peripheral.call(self.location, "isOpen", channel)
end

function Modem:open(channel)
	ArgumentUtils.check(1, channel, "number")
	if not self:isOpen(channel) then
		Peripheral.call(self.location, "open", channel)
		return true
	end
	return false
end

function Modem:close(channel)
	ArgumentUtils.check(1, channel, "number")
	if self:isOpen(channel) then
		Peripheral.call(self.location, "close", channel)
		return true
	end
	return false
end

function Modem:closeAll()
	Peripheral.call(self.location, "closeAll")
end

function Modem:transmit(channel, replyChannel, message)
	ArgumentUtils.check(1, channel, "number")
	ArgumentUtils.check(2, replyChannel, "number")

	Peripheral.call(self.location, "transmit", channel, replyChannel, message)
end

function Modem:isWireless()
	return Peripheral.call(self.location, "isWireless")
end	
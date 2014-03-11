--@import see.io.Peripheral
--@import see.util.ArgumentUtils

--[[
	Wrapper for monitor peripherals
	@param see.base.String:what side the monitor is on (can be on network as well)
]]
function Monitor:init(location)
	if not Peripheral.isPresent(location) then
		throw(InvalidArgumentException:new(1, "see.base.String: location", "invalid location"))
	end

	self.location = location
end

function Monitor:write(text)
	Peripheral.call(self.location, "write", text)
end

function Monitor:clear()
	Peripheral.call(self.location, "clear")
end

function Monitor:clearLine()
	Peripheral.call(self.location, "clearLine")
end

function Monitor:getCursorPos()
	return Peripheral.call(self.location, "getCursorPos")
end

function Monitor:setCursorPos(x, y)
	ArgumentUtils.check(1, x, "number")
	ArgumentUtils.check(2, y, "number")

	Peripheral.call(self.location, "setCursorPos", x, y)
end

function Monitor:setCursorBlink(blink)
	ArgumentUtils.check(1, blink, "boolean")

	Peripheral.call(self.location, "")
end

function Monitor:isColor()
	return Peripheral.call(self.location, "isColor")
end

function Monitor:getSize()
	return Peripheral.call(self.location, "getSize")
end

function Monitor:scroll(n)
	local nn = n or 1
	ArgumentUtils.check(1, nn, "number")

	Peripheral.call(self.location, "scroll", nn)
end

function Monitor:setTextColor(color)
	ArgumentUtils.check(1, color, "number")

	Peripheral.call(self.location, "setTextColor", color)
end

function Monitor:setBackgroundColor(color)
	ArgumentUtils.check(1, color, "number")

	Peripheral.call(self.location, "setBackgroundColor", color)
end

function Monitor:setTextScale(scale)
	ArgumentUtils.check(1, scale, "number")

	Peripheral.call(self.location, "setTextScale", scale)
end
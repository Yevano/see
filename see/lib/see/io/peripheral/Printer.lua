--@import see.io.Peripheral
--@import see.util.ArgumentUtils

--[[
	Wrapper for printer peripherals
	@param see.base.String:what side the printer is on (can be on network as well)
]]
function Printer:init(location)
	if not Peripheral.isPresent(location) then
		throw(InvalidArgumentException:new(1, "see.base.String: location", "invalid location"))
	end

	self.location = location
end

function Printer:getPaperLevel()
	return Peripheral.call(self.location, "getPaperLevel")
end

function Printer:newPage()
	return Peripheral.call(self.location, "newPage")
end

function Printer:endPage()
	return Peripheral.call(self.location, "endPage")
end

function Printer:write(string)
	Peripheral.call(self.location, "write", string)
end

function Printer:setPageTitle(title)
	Peripheral.call(self.location, "setPageTitle", title)
end

function Printer:getInkLevel()
	return Peripheral.call(self.location, "getInkLevel")
end

function Printer:getCursorPos()
	return Peripheral.call(self.location, "getCursorPos")
end

function Printer:setCursorPos(x, y)
	ArgumentUtils.check(1, x, "number")
	ArgumentUtils.check(2, y, "number")
	Peripheral.call(self.location, "setCursorPos", x, y)
end

function Printer:getPageSize()
	return Peripheral.call(self.location, "getPageSize")
end
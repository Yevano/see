--@import see.io.Peripheral

function AbstractPeripheral:init(location)
	if not Peripheral.isPresent(location) then
		throw(InvalidArgumentException:new(1, "see.base.String: location", "invalid location"))
	end

	self.location = location
end
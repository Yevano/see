--@import see.event.Event

function PeripheralDetachEvent:init(side)
	Event.init(self, "peripheral_detach")
	self.side = side
end
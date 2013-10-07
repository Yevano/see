--@import see.event.Event

function PeripheralAttachEvent:init(side)
	Event.init(self, "peripheral")
	self.side = side
end
--@import see.event.Event

--@extends see.event.Event

function PeripheralAttachEvent:init(side)
	Event.init(self, "peripheral")
	self.side = side
end
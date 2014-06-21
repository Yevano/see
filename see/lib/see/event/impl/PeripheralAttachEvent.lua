--@import see.event.Event
--@import see.io.Peripheral

--@extends see.event.Event

function PeripheralAttachEvent:init(side)
	self:super(Event).init("peripheral")
	self.side = side
	self.type = Peripheral.getType(side)
end
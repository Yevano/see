--@import see.event.Event

--@extends see.event.Event

function PeripheralAttachEvent:init(side)
	self:super(Event).init("peripheral")
	self.side = side
end
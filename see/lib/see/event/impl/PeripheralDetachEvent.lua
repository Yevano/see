--@import see.event.Event

--@extends see.event.Event

function PeripheralDetachEvent:init(side)
	self:super(Event).init("peripheral_detach")
	self.side = side
end
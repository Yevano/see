--@import see.event.Event

--@extends see.event.Event

function TurtleInventoryEvent:init(slot)
	self:super(Event).init("turtle_inventory")
	self.slot = slot
end
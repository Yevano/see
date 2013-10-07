--@import see.event.Event

function TurtleInventoryEvent:init(slot)
	Event.init(self, "turtle_inventory")
	self.slot = slot
end
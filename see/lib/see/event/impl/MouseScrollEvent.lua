--@import see.event.Event

--@extends see.event.Event

function MouseScrollEvent:init(direction, x, y)
	self:super(Event).init("mouse_scroll")
	self.direction = direction
	self.x = x
	self.y = y
end
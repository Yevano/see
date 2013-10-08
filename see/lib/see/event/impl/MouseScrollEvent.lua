--@import see.event.Event

--@extends see.event.Event

function MouseScrollEvent:init(direction, x, y)
	Event.init(self, "mouse_scroll")
	self.direction = direction
	self.x = x
	self.y = y
end
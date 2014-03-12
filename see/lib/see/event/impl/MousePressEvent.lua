--@import see.event.Event

--@extends see.event.Event

function MousePressEvent:init(button, x, y)
	self:super(Event).init("mouse_click")
	self.button = button
	self.x = x
	self.y = y
end
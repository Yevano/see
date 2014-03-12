--@import see.event.Event

--@extends see.event.Event

function MouseDragEvent:init(button, x, y)
	self:super(Event).init("mouse_drag")
	self.button = button
	self.x = x
	self.y = y
end
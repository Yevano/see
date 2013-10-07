--@import see.event.Event

function MousePressEvent:init(button, x, y)
	Event.init(self, "mouse_click")
	self.button = button
	self.x = x
	self.y = y
end
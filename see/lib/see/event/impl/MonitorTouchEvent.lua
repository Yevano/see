--@import see.event.Event

function MonitorTouchEvent:init(side, x, y)
	Event.init(self, "monitor_touch")
	self.side = side
	self.x = x
	self.y = y
end
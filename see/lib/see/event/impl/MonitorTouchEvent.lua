--@import see.event.Event

--@extends see.event.Event

function MonitorTouchEvent:init(side, x, y)
	self:super(Event).init("monitor_touch")
	self.side = side
	self.x = x
	self.y = y
end
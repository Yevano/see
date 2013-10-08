--@import see.event.Event

--@extends see.event.Event

function MonitorResizeEvent:init(side)
	Event.init(self, "monitor_resize")
	self.side = side
end
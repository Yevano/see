--@import see.event.Event

--@extends see.event.Event

function MonitorResizeEvent:init(side)
	self:super(Event).init("monitor_resize")
	self.side = side
end
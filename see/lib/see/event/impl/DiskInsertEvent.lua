--@import see.event.Event

--@extends see.event.Event

function DiskInsertEvent:init(side)
	Event.init(self, "disk")
	self.side = side
end
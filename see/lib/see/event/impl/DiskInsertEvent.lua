--@import see.event.Event

function DiskInsertEvent:init(side)
	Event.init(self, "disk")
	self.side = side
end
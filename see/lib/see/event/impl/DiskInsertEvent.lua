--@import see.event.Event

--@extends see.event.Event

function DiskInsertEvent:init(side)
	self:super(Event).init("disk")
	self.side = side
end
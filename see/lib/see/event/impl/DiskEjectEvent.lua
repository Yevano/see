--@import see.event.Event

--@extends see.event.Event

function DiskEjectEvent:init(side)
	self:super(Event).init("disk_eject")
	self.side = side
end
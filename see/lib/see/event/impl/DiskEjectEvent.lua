--@import see.event.Event

--@extends see.event.Event

function DiskEjectEvent:init(side)
	Event.init(self, "disk_eject")
	self.side = side
end
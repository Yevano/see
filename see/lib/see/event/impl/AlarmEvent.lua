--@import see.event.Event

--@extends see.event.Event

function AlarmEvent:init(id)
	Event.init(self, "alarm")
	self.id = id
end
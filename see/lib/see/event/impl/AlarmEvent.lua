--@import see.event.Event

--@extends see.event.Event

function AlarmEvent:init(id)
	self:super(Event).init("alarm")
	self.id = id
end
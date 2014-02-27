--@import see.event.Event

--@extends see.event.Event

function TimerEvent:init(id)
	self:super(Event).init("timer")
	self.id = id
end
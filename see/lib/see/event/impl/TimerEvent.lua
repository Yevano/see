--@import see.event.Event

function TimerEvent:init(id)
	Event.init(self, "timer")
	self.id = id
end
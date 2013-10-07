--@import see.event.Event

function AlarmEvent:init(id)
	Event.init(self, "alarm")
	self.id = id
end
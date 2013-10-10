--@import see.event.Event

--@extends see.event.Event

function KeyPressEvent:init(key)
	Event.init(self, "key")
	self.key = key
end
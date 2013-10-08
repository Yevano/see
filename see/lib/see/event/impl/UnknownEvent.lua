--@import see.event.Event

--@extends see.event.Event

function UnknownEvent:init(ident, ...)
	Event.init(self, ident)
	self.args = {...}
end
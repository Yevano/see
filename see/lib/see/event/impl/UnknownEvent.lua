--@import see.event.Event

--@extends see.event.Event

function UnknownEvent:init(ident, ...)
	self:super(Event).init(ident)
	self.args = {...}
end
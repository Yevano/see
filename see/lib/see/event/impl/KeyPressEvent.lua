--@import see.event.Event

--@extends see.event.Event

function KeyPressEvent:init(key)
	self:super(Event).init("key")
	self.key = key
end
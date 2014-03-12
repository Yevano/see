--@import see.event.Event

--@extends see.event.Event

function CharEvent:init(char)
	self:super(Event).init("char")
	self.char = char
end
--@import see.event.Event

--@extends see.event.Event

function CharEvent:init(char)
	Event.init(self, "char")
	self.char = char
end
--@import see.event.Event

--@extends see.event.Event

function PasteEvent:init(text)
	self:super(Event).init("paste")
	self.text = text
end
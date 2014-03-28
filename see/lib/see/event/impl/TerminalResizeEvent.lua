--@import see.event.Event

--@extends see.event.Event

function TerminalResizeEvent:init()
	self:super(Event).init("term_resize")
end
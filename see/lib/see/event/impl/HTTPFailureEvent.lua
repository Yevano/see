--@import see.event.Event

--@extends see.event.Event

function HTTPFailureEvent:init(url)
	self:super(Event).init("http_failure")
	self.url = url
end
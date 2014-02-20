--@import see.event.Event

--@extends see.event.Event

function HTTPFailureEvent:init(url)
	Event.init(self, "http_failure")
	self.url = url
end
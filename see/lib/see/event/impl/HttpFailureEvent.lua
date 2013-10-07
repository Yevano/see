--@import see.event.Event

function HttpFailureEvent:init(url)
	Event.init(self, "http_failure")
	self.url = url
end
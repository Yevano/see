--@import see.event.Event

--@extends see.event.Event

function TestEvent:init(message)
    Event.init(self, "test")
    self.message = message
end
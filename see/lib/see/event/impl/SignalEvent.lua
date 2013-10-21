--@import see.event.Event
--@import see.concurrent.Thread

--@extends see.event.Event

function SignalEvent:init(message)
    Event.init(self, "signal")
    self.sender = Thread.current()
    self.message = message
end
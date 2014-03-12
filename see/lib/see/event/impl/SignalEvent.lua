--@import see.event.Event
--@import see.concurrent.Thread

--@extends see.event.Event

function SignalEvent:init(message)
    self:super(Event).init("signal")
    self.sender = Thread.current()
    self.message = message
end
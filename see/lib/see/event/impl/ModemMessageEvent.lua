--@import see.event.Event
--@import see.base.System

--@extends see.event.Event

function ModemMessageEvent:init(side, channel, replyChannel, message, distance)
	self:super(Event).init("modem_message")
	self.side = side
	self.channel = channel
	self.replyChannel = replyChannel
    System.print(message)
	self.message = message
	self.distance = distance
end
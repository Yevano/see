--@import see.event.Event

--@extends see.event.Event

function ModemMessageEvent:init(side, channel, replyChannel, message, distance)
	self:super(Event).init("modem_message")
	self.side = side
	self.channel = channel
	self.replyChannel = replyChannel
	self.message = message
	self.distance = distance
end
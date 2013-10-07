--@import see.event.Event

function ModemMessageEvent:init(side, channel, replyChannel, message, distance)
	Event.init(self, "modem_message")
	self.side = side
	self.channel = channel
	self.replyChannel = replyChannel
	self.message = message
	self.distance = distance
end
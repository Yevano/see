--@import see.event.Event

--@extends see.event.Event

--[[
	For compatibility's sake only. Use ModemMessageEvent instead.
]]

function RednetMessageEvent:init(sender, message, distance)
	Event.init(self, "rednet_message")
	self.sender = sender
	self.message = message
	self.distance = distance
end
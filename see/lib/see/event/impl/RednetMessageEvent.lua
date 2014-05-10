--@import see.event.Event

--@extends see.event.Event

--[[
	For compatibility's sake only. Use ModemMessageEvent instead.
]]

function RednetMessageEvent:init(sender, message, protocol)
	self:super(Event).init("rednet_message")
	self.sender = sender
	self.message = message
	self.protocol = protocol
end
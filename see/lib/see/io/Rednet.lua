--@import see.event.Events
--@import see.event.impl.RednetMessageEvent
--@import see.event.impl.TimerEvent
--@import see.io.RednetConnection
--@import see.util.ArgumentUtils

--@native rednet
--@native os.startTimer

function Rednet.open(modem)
	rednet.open(modem)
end

function Rednet.close(modem)
	rednet.close(modem)
end

function Rednet.isOpen(modem)
	return rednet.isOpen(modem)
end

function Rednet.send(id, message, protocol)
	rednet.send(id, message, protocol)
end

function Rednet.broadcast(message, protocol)
	rednet.broadcast(message, protocol)
end

--[[
	Receive from Rednet
	@param see.base.String:protocol Protocol to receive from
	@param number:timeout Timeout before returning if no message received
	@param number:sender Id to receive from
	@return see.events.impl.RednetMessageEvent The Rednet event, or nil if unsuccessful
]]
function Rednet.receive(protocol, timeout, sender)
	if protocol then protocol = cast(protocol, "string") end
	if timeout then ArgumentUtils.check(2, timeout, "number") end
	if sender then ArgumentUtils.check(3, sender, "number") end

	-- Start the timer
	local timer = nil
	if timeout then
		timer = os.startTimer(timeout)
	end

	-- Wait for events
	while true do
		local event = Events.pull(RednetMessageEvent, TimerEvent)
		if event.ident == "rednet_message" then
			-- Return the first matching rednet_message
			if (protocol == nil or protocol == event.protocol) and (sender == nil or sender == event.sender) then
				return event
			end
		elseif event.ident == "timer" and event.id == timer then
			-- Return nil if we timeout
			return nil
		end
	end
end

function Rednet.host(protocol, name)
	rednet.host(protocol, name)
end

function Rednet.unhost(protocol)
	retnet.unhost(protocol)
end

--[[
	Receive from Rednet
	@param see.base.String:protocol Protocol to lookup
	@param see.base.String:hostname Name of user to filter to
	@param number:timeout Time period to wait for responses (defaults to 2)
	@return see.base.Array[see.io.RednetConnection] List of matching connections, 
		or see.io.RednetConnection if hostname is specified.
]]
function Rednet.lookup(protocol, hostname, timeout)
	protocol = cast(protocol, "string")
	if hostname then hostname = cast(hostname, "string") end
	if timeout then
		ArgumentUtils.check(3, timeout, "number")
	else
		timeout = 2
	end

	Rednet.broadcast({
		sType = "lookup",
		sProtocol = protocol,
		sHostname = hostname,
	}, "dns")

	local timer = os.startTimer(timeout)

	local results = Array:new()

	while true do
		local event = Events.pull(RednetMessageEvent, TimerEvent)
		if event.ident == "rednet_message" then
			-- Got a rednet message, check if it's the response to our request
			if event.protocol == "dns" and event.message.sType == "lookup response" then
				if event.message.sProtocol == protocol then
					if hostname == nil then
						results:add(RednetConnection:new(event.sender, STR(protocol), STR(event.message.sHostname)))
					elseif event.message.sHostname == hostname then
						return RednetConnection:new(event.sender, STR(protocol), STR(event.message.sHostname))
					end
				end
			end
		elseif event.ident == "timer" and event.id == timer then
			break
		end
	end
	
	return results
end
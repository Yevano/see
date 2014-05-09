--@import see.base.String
--@import see.io.Rednet
--@import see.util.ArgumentUtils

--[[
	A way of managing a single rednet connection
]]

--[[
    Constructs a new RednetConnection
    @param number:id The id of the computer to send and receive from
    @param see.base.String:protocol The protocol to send and recieve with
    @param see.base.String:hostname The computer's hostname gathered with lookup
]]
function RednetConnection:init(id, protocol, hostname)
	ArgumentUtils.check(1, id, "number")
	if protocol then cast(protocol, String) end
	if hostname then cast(hostname, String) end

	self.id = id
	self.protocol = protocol
	self.hostname = hostname
end

--[[
	Receive from connection's id (with protocol if needed)
	@param number:timeout Timeout before returning if no message received
	@return see.base.String The received message, or nil on error
]]
function RednetConnection:receive(timeout)
	local message = Rednet.receive(self.protocol, timeout, self.id)
	if message then
		return STR(message.message)
	end
	return nil
end

--[[
	Send a message to connection (with protocol if needed)
	@param any:message Object to send
]]
function RednetConnection:send(message)
	Rednet.send(self.id, message, self.protocol)
end
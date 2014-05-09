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
	if protocol then ArgumentUtils.check(2, protocol, String) end
	if hostname then ArgumentUtils.check(3, hostname, String) end

	self.id = id
	self.protocol = protocol
	self.hostname = hostname
end

--[[
	Receive from connection's id (with protocol if needed)
	@param number:timeout Timeout before returning if no message received
]]
function RednetConnection:receive(timeout)
	return Rednet.receive(self.protocol, timeout, self.id)
end

--[[
	Send a message to connection (with protocol if needed)
	@param any:message Object to send
]]
function RednetConnection:send(message)
	Rednet.send(self.id, message, self.protocol)
end
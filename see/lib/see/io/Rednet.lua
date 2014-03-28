--@native rednet

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

function Rednet.receive(protocol, timeout)
	return rednet.receive(protocol, timeout)
end

function Rednet.host(protocol, name)
	rednet.host(protocol, name)
end

function Rednet.unhost(protocol)
	retnet.unhost(protocol)
end

function Rednet.lookup(protocol, name)
	return rednet.lookup(protocol, name)
end
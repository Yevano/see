--@import see.io.peripheral.Modem
--@import see.io.InputStream
--@import see.util.ArgumentUtils
--@import see.concurrent.Thread

--@extends see.io.InputStream

--@native os.startTimer

function ModemInputStream:init(modem, channel)
	self.modem = modem
	self.channel = channel
	self.buffer = Array:new()
	self.running = true
	self.thread = Thread:new(function()
		while self.running do
			local id = os.startTimer(0.1)
			local evt 
			try(function()
				evt = Events.pull("modem_message", "timer")
			end, function(e) end)

			if evt then
				if evt.ident == "timer" and evt.id == id then
					Thread.work() --experimental
				elseif evt.ident == "modem_message" then
					if evt.channel == channel then
						local val = STR(evt.message):toNumber()  --too simple? probably
						self.buffer:add(val)
					else
						--crap, what now... cant just "re-queue" it.. or can we.. hmmmmmm
						Events.queue(evt) --HIGHLY EXPERIMENTAL, PROBABLY CAUSES HORRIBLE SHIT TO GO DOWN
						Thread.yield() 
					end
				end
			end
		end
	end)

	self.modem:open(channel)
	self.thread:start()
end

--[[
	Reads a byte
]]
function ModemInputStream:read()
	if self.buffer:length() == 0 then
		return -1
	end

	return self.buffer:remove(1)
end

--[[
	Returns the number of bytes available
]]
function ModemInputStream:available()
	return self.buffer:length()
end

function ModemInputStream:close()
	Thread:new(function()
		self.modem:close(self.channel)

		self.running = false
		self.thread:interrupt()
		self.thread:join()
	end):start()
end
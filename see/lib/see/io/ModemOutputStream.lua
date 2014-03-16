--@import see.io.peripheral.Modem
--@import see.io.OutputStream
--@import see.util.ArgumentUtils

--@extends see.io.OutputStream

function ModemOutputStream:init(modem, channel, replyChannel)
	self.modem = modem
	self.channel = channel
	self.replyChannel = replyChannel

	self.modem:open(channel)
end

function ModemOutputStream:write(b)
	ArgumentUtils.check(1, b, "number")
	self.modem:transmit(self.channel, self.replyChannel, STR(b):lstr())
end

function ModemOutputStream:close()
	self.modem:close(self.channel)
end
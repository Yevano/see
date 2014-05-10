--@import see.io.Peripheral
--@import see.io.ArrayInputStream
--@import see.io.ArrayOutputStream
--@import see.io.DataInputStream
--@import see.io.DataOutputStream

--@import see.util.Math

--@import linknet.net.NetCodec
--@import linknet.net.LinknetProtocol

--@import linknet.packet.Packet
--@import linknet.packet.ReplyDiscoveryPacket
--@import linknet.packet.RequestDiscoveryPacket

function NetworkDiscoverer:init(channel)
    self.channel = channel
    self.routes = Array:new()
    self.direct = { }
    self:findModems()
end

function NetworkDiscoverer:findModems()
    self.wireless = nil
    self.wired = Array:new()
    for name in Peripheral.getNames():iAll() do
        if Peripheral.getType(name) == STR"modem" then
            if Peripheral.call(name, "isWireless") then
                -- No point of using more than one wireless modem.
                if not self.wireless then self.wireless = name end
            else
                self.wired:add(name)
            end
        end
    end
end

function NetworkDiscoverer:discover(timeout)
    local t = Thread.current()
    Thread:new(function()
        Thread.sleep(timeout)
        t:interrupt()
    end):start()

    -- Can't discover if no modems are present.
    if not self.wireless and self.wired:length() == 0 then return end

    -- Random id to differentiate between other discovery requests.
    local uid = Math.random(0, Math.pow(2, 32) - 1)

    local rawRequest = String:new()
    local requestPacket = RequestDiscoveryPacket:new(uid)
    requestPacket:write(DataOutputStream:new(ArrayOutputStream:new(rawRequest.charArray)))
    local request = NetCodec.encodeRednetBinary(rawRequest)

    -- Send the request on all modems.
    if self.wireless then
        Peripheral.call(self.wireless, "transmit", self.channel, self.channel, request)
    end

    for modem in self.wired:iAll() do
       Peripheral.call(modem, "transmit", self.channel, self.channel, request) 
    end

    -- Wait for replies.
    local waiting = true
    while true do
        local event
        try(function()
            event = Events.pull("modem_message")
        end, function(e)
            waiting = false
        end)
        if not waiting then break end
        local reply = NetCodec.decodeRednetBinary(event.message)
        if not reply then return end
        local packet = Packet.read(DataInputStream:new(ArrayInputStream:new(reply.charArray)))
        if packet and packet.id == LinknetProtocol.REPLY_DISCOVERY and packet.uid == uid then
            self.direct[packet.address] = true
        end
    end
end

function NetworkDiscoverer:serveDiscovery()
    while true do
        local event
        try(function()
            event = Events.pull("modem_message")
        end, function(e)
            waiting = false
        end)
        if not waiting then break end
        local request = NetCodec.decodeRednetBinary(event.message)
        if not request then return end
        local packet = Packet.read(DataInputStream:new(ArrayInputStream:new(request.charArray)))
        if packet and packet.id == LinknetProtocol.REQUEST_DISCOVERY then
            local rawReply = String:new()
            local replyPacket = ReplyDiscoveryPacket:new(uid, System.getID())
            replyPacket:write(DataOutputStream:new(ArrayOutputStream:new(rawReply.charArray)))
            local reply = NetCodec.encodeRednetBinary(rawReply)

            -- Send the reply on the modem the request was read.
            Peripheral.call(event.side, "transmit", self.channel, self.channel, reply)
        end
    end
end
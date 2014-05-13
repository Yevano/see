--@import see.concurrent.Thread

--@import see.event.impl.ModemMessageEvent

--@import see.io.Peripheral
--@import see.io.ArrayInputStream
--@import see.io.ArrayOutputStream
--@import see.io.DataInputStream
--@import see.io.DataOutputStream

--@import see.util.Math
--@import see.util.Timer

--@import see.linknet.net.NetCodec
--@import see.linknet.net.LinknetProtocol

--@import see.linknet.packet.Packet
--@import see.linknet.packet.ReplyDiscoveryPacket
--@import see.linknet.packet.RequestDiscoveryPacket

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
                if not self.wireless then
                    self.wireless = name
                    Peripheral.call(name, "open", self.channel)
                end
            else
                self.wired:add(name)
                Peripheral.call(name, "open", self.channel)
            end
        end
    end
end

function NetworkDiscoverer:discover(timeout)
    local t = Thread.current()
    local timer = Timer:new(timeout, function()
        t:interrupt()
    end, false):start()

    -- Can't discover if no modems are present.
    if not self.wireless and self.wired:length() == 0 then return end

    -- Random id to differentiate between other discovery requests.
    local uid = Math.random(0, Math.pow(2, 30))

    local rawRequest = String:new()
    local requestPacket = RequestDiscoveryPacket:new(uid)
    requestPacket:write(DataOutputStream:new(ArrayOutputStream:new(rawRequest.charArray)))
    local request = NetCodec.encodeRednetBinary(rawRequest)

    -- Send the request on all modems.
    if self.wireless then
        Peripheral.call(self.wireless, "transmit", self.channel, self.channel, request:lstr())
    end

    for modem in self.wired:iAll() do
       Peripheral.call(modem, "transmit", self.channel, self.channel, request:lstr())
    end

    -- Wait for replies.
    local waiting = true
    while true do
        local event
        try(function()
            event = Events.pull(ModemMessageEvent)
            System.print("GOT A MESSAGE")
        end, function(e)
            waiting = false
        end)
        if not waiting then break end
        local reply = NetCodec.decodeRednetBinary(event.message)
        if not reply then return end
        local packet = Packet.read(DataInputStream:new(ArrayInputStream:new(reply.charArray)))
        System.print(packet)
        System.print(packet.id)
        System.print(packet.uid)
        if packet and packet.id == LinknetProtocol.REPLY_DISCOVERY and packet.uid == uid then
            self.direct[packet.address] = true
        end
    end
end

function NetworkDiscoverer:serveDiscovery()
    local waiting = true
    while true do
        local event
        try(function()
            event = Events.pull(ModemMessageEvent)
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
            Peripheral.call(event.side, "transmit", self.channel, self.channel, reply:lstr())
        end
    end
end
--@import see.linknet.packet.Packet
--@import see.linknet.net.LinknetProtocol

--@extends see.linknet.packet.Packet

function RequestDiscoveryPacket.__static()
    Packet.register(LinknetProtocol.REQUEST_DISCOVERY, RequestDiscoveryPacket)
end

function RequestDiscoveryPacket:init(uid)
    self.uid = uid
end

function RequestDiscoveryPacket:read(stream)
    self.uid = stream:readUnsignedInt(4)
end

function RequestDiscoveryPacket:write(stream)
    self:super(Packet).write(stream)
    stream:writeUnsignedInt(self.uid, 4)
end
--@import linknet.packet.Packet
--@import linknet.net.LinknetProtocol

--@extends linknet.packet.Packet

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
    Packet.write(self, stream)
    stream:writeUnsignedInt(self.uid, 4)
end
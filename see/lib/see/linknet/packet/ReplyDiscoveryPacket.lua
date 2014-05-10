--@import linknet.packet.Packet
--@import linknet.net.LinknetProtocol

--@extends linknet.packet.Packet

function ReplyDiscoveryPacket.__static()
    Packet.register(LinknetProtocol.REPLY_DISCOVERY, ReplyDiscoveryPacket)
end

function ReplyDiscoveryPacket:init(uid, address)
    self.uid = uid
    self.address = address
end

function ReplyDiscoveryPacket:read(stream)
    self.uid = stream:readUnsignedInt(4)
    self.address = stream:readUnsignedInt(4)
end

function ReplyDiscoveryPacket:write(stream)
    Packet.write(self, stream)
    stream:writeUnsignedInt(self.uid, 4)
    stream:writeUnsignedInt(self.address, 4)
end
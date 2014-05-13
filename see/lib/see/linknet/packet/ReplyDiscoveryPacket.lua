--@import see.linknet.packet.Packet
--@import see.linknet.net.LinknetProtocol

--@extends see.linknet.packet.Packet

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
    self:super(Packet).write(stream)
    stream:writeUnsignedInt(self.uid, 4)
    stream:writeUnsignedInt(self.address, 4)
end
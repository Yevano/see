Packet.MAGIC = 0xDEADBEEF
local idsToPackets = { }
local packetsToIDs = { }

function Packet.read(stream)
    local magic = stream:readUnsignedInt(4)
    if magic ~= Packet.MAGIC then return end
    local id = stream:readUnsignedInt(1)
    local class = idsToPackets[id]
    if not class then return end
    local packet = class:new()
    packet:read(stream)
    return packet
end

function Packet.register(id, class)
    idsToPackets[id] = class
    packetsToIDs[class] = id
end

function Packet:write(stream)
    stream:writeUnsignedInt(Packet.MAGIC, 4)
    stream:writeUnsignedInt(packetsToIDs[typeof(self)], 1)
end
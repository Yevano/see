LinknetProtocol.REQUEST_DISCOVERY = LinknetProtocol.register()
LinknetProtocol.REPLY_DISCOVERY   = LinknetProtocol.register()
LinknetProtocol.REQUEST_ROUTE     = LinknetProtocol.register()
LinknetProtocol.REPLY_ROUTE       = LinknetProtocol.register()
LinknetProtocol.SEND              = LinknetProtocol.register()

local packets = 0

function LinknetProtocol.register()
    packets = packets + 1
    return packets
end
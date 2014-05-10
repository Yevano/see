function MessageSender:init(discoverer)
    self.discoverer = discoverer
end

function MessageSender:send(id, message)
    message = cast(message, String)
end
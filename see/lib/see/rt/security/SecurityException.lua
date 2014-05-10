--@import see.rt.RuntimeException

function SecurityException:init(message)
    self:super(RuntimeException).init(message)
end
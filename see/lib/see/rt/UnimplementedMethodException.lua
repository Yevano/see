--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function UnimplementedMethodException:init(message)
    self:super(RuntimeException).init(message)
end
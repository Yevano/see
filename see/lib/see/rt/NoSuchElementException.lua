--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function NoSuchElementException:init(message)
    self:super(RuntimeException).init(message)
end
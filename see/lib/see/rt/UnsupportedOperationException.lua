--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function UnsupportedOperationException:init(message)
	self:super(RuntimeException).init(message)
end
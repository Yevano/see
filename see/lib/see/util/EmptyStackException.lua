--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function EmptyStackException:init(message)	
	self:super(RuntimeException).init(message)
end
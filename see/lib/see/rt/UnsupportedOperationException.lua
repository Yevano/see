--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function UnsupportedOperationException:init(message)
	RuntimeException.init(self, message)
end
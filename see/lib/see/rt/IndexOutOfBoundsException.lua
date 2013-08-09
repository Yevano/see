--@import see.rt.RuntimeException
--@import see.base.String
--@extends see.rt.RuntimeException

function IndexOutOfBoundsException:init(index)
	RuntimeException.init(self, String.new("Index: " .. index))
end
--@import see.rt.RuntimeException
--@extends see.rt.RuntimeException

function InvalidArgumentException:init(n, expected, got)
	if not isprimitive(expected) then
		expected = exepected:getName()
	end
	if not isprimitive(got) then
		got = got:getName()
	end

	RuntimeException.init(self, String.new("Invalid argument #", n, ". Expected ", expected, ", got ", got, "."))
end
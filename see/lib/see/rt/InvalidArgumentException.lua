--@import see.rt.RuntimeException
--@import see.base.String
--@extends see.rt.RuntimeException

--[[
    Describes an exception which occurs while processing arguments.
]]

function InvalidArgumentException:init(n, expected, got)
    if not isprimitive(expected) then
        expected = expected:getName()
    end
    if not isprimitive(got) then
        got = got:getName()
    end

    self:super(RuntimeException).init(STR("Invalid argument #", n, ". Expected ", expected, ", got ", got, "."))
end
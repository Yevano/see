--@import see.rt.RuntimeException
--@import see.base.String
--@extends see.rt.RuntimeException

--[[
    Describes an exception which occurs on invalid bounds access or setting.
]]

function IndexOutOfBoundsException:init(index)
    RuntimeException.init(self, String.new("Index: " .. index))
end
--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function NoSuchElementException:init(message)
    RuntimeException.init(self, message)
end
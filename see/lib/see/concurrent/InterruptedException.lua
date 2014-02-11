--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function InterruptedException:init()
    RuntimeException.init(self, "")
end
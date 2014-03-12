--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function InterruptedException:init()
    self:super(RuntimeException).init("Thread interrupted.")
end
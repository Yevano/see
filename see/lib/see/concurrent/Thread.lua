--@native coroutine
--@native threadpool

Thread.SUSPENDED = "suspended"
Thread.RUNNING = "running"
Thread.DEAD = "dead"

--[[
    Yields the current thread.
    @param any... Passes these arguments back to the resuming thread.
    @return any... Values passed from the resuming thread.
]]
function Thread.yield(...)
    return coroutine.yield(...)
end

function Thread.current()
    return threadpool.current
end

--[[
    Constructs a new Thread.
    @param function:func The function to run in a new thread.
]]
function Thread:init(func)
    self.func = func
    self.id = threadpool:add(self)
end

--[[
    Gets the status of this Thread.
    @return string Thread state.
]]
function Thread:status()
    return coroutine.status(self.co)
end

--[[
    Checks whether or not this Thread is running.
    @return boolean True if the Thread is running or false if not.
]]
function Thread:isRunning()
    return coroutine.running(self.co)
end
--@native coroutine

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

--[[
    Constructs a new Thread.
    @param function:func The function to run in a new thread.
]]
function Thread:init(func)
    self.co = coroutine.create(func)
end

--[[
    Resumes this Thread. Passes the given arguments to the thread as it is resumed.
    @param any... Arguments to pass to the thread.
    @return any... Values passed from the thread.
]]
function Thread:resume(...)
    return coroutine.resume(self.co, ...)
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
--@native coroutine
--@native sleep

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
    Sleeps for s seconds.
    @param number:s Seconds.
]]
function Thread.sleep(s)
    sleep(s)
end

--[[
    Constructs a new Thread.
    @param function:func The function to run in a new thread.
]]
function Thread:init(func)
    self.co = coroutine.create(func)
end

--[[
    Resumes a suspended coroutine.
]]
function Thread:resume()
    coroutine.resume(self.co)
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
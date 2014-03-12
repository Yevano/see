--@native coroutine
--@native __rt
--@native os.startTimer
--@native print

--@import see.event.Events

Thread.SUSPENDED = "suspended"
Thread.RUNNING = "running"
Thread.DEAD = "dead"

local threads = { }

--[[
    Yields the current thread.
    @param any... Passes these arguments back to the resuming thread.
    @return any... Values passed from the resuming thread.
]]
function Thread.yield(...)
    return coroutine.yield(...)
end

function Thread.current()
    return __rt.objThreads[coroutine.running()]
end

function Thread.work(t)
    t = t or 1/80
    local thread = Thread.current()

    if thread.workStart then
        if System.clock() - thread.workStart > t then
            Thread.sleep()
            thread.workStart = System.clock()
        end
    else
        thread.workStart = System.clock()
    end
end

--[[
    Sleeps for s seconds.
    @param number:s Seconds.
]]
function Thread.sleep(s)
    local id = os.startTimer(s or 0)
    while id ~= Events.pull("timer").id do end
end

--[[
    Constructs a new Thread.
    @param function:func The function to run in a new thread.
]]
function Thread:init(func)
    self.func = func
end

--[[
    Add thread to the event dispatcher.
]]
function Thread:start()
    self.co = __rt:spawnThread(self.func, self)
end

--[[
    Interrupt thread.
]]
function Thread:interrupt()
    __rt:interruptThread(self)
end

--[[
    Wait until the thread has terminated.
]]
function Thread:join()
    while self:isAlive() do
        Thread.sleep()
    end
end

--[[
    Gets the status of this Thread.
    @return string Thread state.
]]
function Thread:status()
    return coroutine.status(self.co)
end

--[[
    Check if the thread is alive.
    @return boolean Alive.
]]
function Thread:isAlive()
    return self:status() ~= Thread.DEAD
end
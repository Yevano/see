--@import see.concurrent.Thread

function Task:init(func, ...)
    local args = Array:new(...)
    self.thread = Thread:new(function()
        self.result = func(args:unpack())
        if self.callback then
            self.callback(self.result)
        end
    end)
    self.thread:start()
end

function Task:setCallback(callback)
    if self:isFinished() then
        callback(self.result)
    else
        self.callback = callback
    end

    return self
end

function Task:isFinished()
    return not self.thread:isAlive()
end

function Task:wait()
    self.thread:join()
    return self.result
end
--@native os.pullEvent
--@native unpack

--@import see.hook.Hook
--@import see.concurrent.Thread

local hooks = { }
local running

function Hooks.run()
    local eventData = Array.new(os.pullEvent())
    if eventData:length() == 0 then
        return
    end
    local event = eventData[1]
    eventData:remove(1)
    if hooks[event] then
        for hook in hooks[event]:iAll() do
            hook.callback(eventData:unpack())
        end
    end
end

function Hooks.add(event, callback)
    local t = hooks[event]
    if not t then
        t = Array.new()
        hooks[event] = t
    end
    local hook = Hook.new(#t + 1, event, callback)
    t:add(hook)
    return hook
end

function Hooks.remove(hook)
    hooks[hook.event]:remove(hook.id)
    hook.id = -1
end
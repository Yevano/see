--@import see.concurrent.Thread
--@import see.concurrent.InterruptedException

--@import see.util.VarArgs

--@import see.rt.InvalidArgumentException

--@import see.event.Event
--@import see.event.impl.CharEvent
--@import see.event.impl.KeyPressEvent
--@import see.event.impl.TimerEvent
--@import see.event.impl.AlarmEvent
--@import see.event.impl.RedstoneEvent
--@import see.event.impl.TerminateEvent
--@import see.event.impl.DiskInsertEvent
--@import see.event.impl.DiskEjectEvent
--@import see.event.impl.PeripheralAttachEvent
--@import see.event.impl.PeripheralDetachEvent
--@import see.event.impl.RednetMessageEvent
--@import see.event.impl.ModemMessageEvent
--@import see.event.impl.HTTPSuccessEvent
--@import see.event.impl.HTTPFailureEvent
--@import see.event.impl.MousePressEvent
--@import see.event.impl.MouseScrollEvent
--@import see.event.impl.MouseDragEvent
--@import see.event.impl.MonitorTouchEvent
--@import see.event.impl.MonitorResizeEvent
--@import see.event.impl.TurtleInventoryEvent
--@import see.event.impl.UnknownEvent
--@import see.event.impl.SignalEvent

--@native os.queueEvent

local registeredEvents
local registeredEventsReverse
local nativeEvents

function Events.__static()
    registeredEvents = { }
    registeredEventsReverse = { }
    nativeEvents = { }
    
    Events.register("char",              CharEvent)
    Events.register("key",               KeyPressEvent)
    Events.register("timer",             TimerEvent)
    Events.register("alarm",             AlarmEvent)
    Events.register("redstone",          RedstoneEvent)
    Events.register("terminate",         TerminateEvent)
    Events.register("disk",              DiskInsertEvent)
    Events.register("disk_eject",        DiskEjectEvent)
    Events.register("peripheral",        PeripheralAttachEvent)
    Events.register("peripheral_detach", PeripheralDetachEvent)
    Events.register("rednet_message",    RednetMessageEvent)
    Events.register("modem_message",     ModemMessageEvent)
    Events.register("http_success",      HTTPSuccessEvent)
    Events.register("http_failure",      HTTPFailureEvent)
    Events.register("mouse_click",       MousePressEvent)
    Events.register("mouse_scroll",      MouseScrollEvent)
    Events.register("mouse_drag",        MouseDragEvent)
    Events.register("monitor_touch",     MonitorTouchEvent)
    Events.register("monitor_resize",    MonitorResizeEvent)
    Events.register("turtle_inventory",  TurtleInventoryEvent)
    Events.register("signal",            SignalEvent)

    Events.registerNative("op_tick_sync")
end

--[[
    Register a native event
]]
function Events.registerNative(ident)
    nativeEvents[ident] = true
end

--[[
    Checks if an event ident is native
]]
function Events.isNativeEvent(ident)
    return nativeEvents[ident]
end

--[[
    Registers an event
    @param see.base.String / string event identifier
    @param see.rt.Class the class of the event
]]
function Events.register(ident, eventClass)
    registeredEvents[cast(ident, "string")] = eventClass
    registeredEventsReverse[eventClass] = cast(ident, "string")
end

--[[
    Gets an event class by its identifier
]]
function Events.getEventClass(ident)
    return registeredEvents[cast(ident, "string")] or UnknownEvent
end

--[[
    Queue an event
]]
function Events.queue(event)
    os.queueEvent(cast(event.ident, "string"), event)
end

--[[
    Pulls an event
]]
function Events.pull(...)
    local args = Array:new(...)
    local casted = Array:new()
    for i = 1, args:length() do
        local arg = args:get(i)
        if arg:isAssignableFrom(Event) then
            casted:add(registeredEventsReverse[arg])
        else
            throw(InvalidArgumentException:new(i, "Event", arg))
        end
    end

    while true do
        local ret = Thread.yield(casted:unpack())

        if ret == "__thread_interrupt" then
            throw(InterruptedException:new())
        end

        return ret
    end
end

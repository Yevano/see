--@import see.concurrent.Thread
--@import see.dev.TestEvent
--@import see.util.Math

function Test.main()
    Events.register("test", TestEvent)
    System.print("Hello World!")

    for i = 1, 4 do
        Thread.new(function()
            System.print("Hello from thread " .. i .. "!")

            local event = Events.pull("test")
            local message = event.message
            repeat
                System.print("T[" .. i .. "] " .. message)
                event = Events.pull("test")
                message = event.message
            until message == "stop"
        end):start()
    end

    for i = 1, 3 do
        Events.queue(TestEvent.new(Math.random()))
    end

    Events.queue(TestEvent.new("stop"))
end
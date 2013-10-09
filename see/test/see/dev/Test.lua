--@import see.concurrent.Thread
--@import see.dev.TestEvent
--@import see.util.Math

--@native os.queueEvent

function Test.main()
    System.print("Hello World!")
    Events.register("test", TestEvent)

    Thread.new(function()
        System.print("Hello Thread!")
        for i = 1, 8 do
            local event = Events.pull("test")
            System.print("T2[" .. i .. "] " .. event.message)
        end
    end):start()

    while true do
        Thread.sleep(1)
        Events.queue(TestEvent.new(Math.random()))
    end
end
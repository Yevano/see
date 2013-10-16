--@import see.concurrent.Thread
--@import see.concurrent.Task

function Test.main()
    local piTask = Task.new(calculatePi, 200000):setCallback(function(result)
        System.print("\n" .. result)
    end)

    System.write("Waiting")

    repeat
        Thread.sleep(1)
    until piTask:isFinished() or System.write(".")
end

function calculatePi(iter)
    local pi = 4
    for i = 1, iter * 2, 2 do
        Thread.work()
        pi = pi - (4/(1 + i * 2))
        pi = pi + (4/(3 + i * 2))
    end
    return pi
end
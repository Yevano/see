--@import see.concurrent.Thread

function ExTest.main()
    local thread = Thread.new(function()
        local function f(x)
            if x == 0 then
                throw(Exception.new("TEST"))
            end
            f(x - 1)
        end
        f(8)
    end)
    thread:start()
    thread:join()
    System.print("hi")
end
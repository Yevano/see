--@import see.rt.RuntimeException

function Test.main()
    try(function()
        throw(RuntimeException:new("hello"))
    end, function(e)
        System.print(e:getClass())
    end)
end
--@import see.hook.Hooks

function Test.main()
    local hook
    local input = true
    local str = String.new()
    hook = Hooks.add("char", function(c)
        if c == "z" then
            input = false
            Hooks.remove(hook)
        else
            str:add(c)
        end
    end)

    while input do
        Hooks.run()
    end

    System.print(str)
end
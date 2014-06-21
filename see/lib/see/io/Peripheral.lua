--@native peripheral

--@import see.util.VarArgs
--@import see.io.IOException

function Peripheral.isPresent(side)
    return peripheral.isPresent(cast(side, "string"))
end

function Peripheral.getType(side)
    return String:new(peripheral.getType(cast(side, "string")))
end

function Peripheral.getMethods(side)
    if not Peripheral.isPresent(side) then throw(IOException:new("No connected peripheral on " .. side .. " side.")) end
    methods = Array:new(VarArgs.unpack(peripheral.getMethods(cast(side, "string"))))
    for i = 1, methods:length() do
        methods[i] = STR(methods[i])
    end
    return methods
end

function Peripheral.call(side, method, ...)
    if not Peripheral.isPresent(side) then throw(IOException:new("No connected peripheral on " .. side .. " side.")) end

    local args = Array:new(...)

    for i = 1, args:length() do
        if typeof(args[i]) == String then
            args[i] = cast(args[i], "string")
        end
    end

    return peripheral.call(cast(side, "string"), cast(method, "string"), args:unpack())
end

function Peripheral.getNames()
    local names = Array:new(VarArgs.unpack(peripheral.getNames()))
    for i = 1, names:length() do
        names[i] = STR(names[i])
    end
    return names
end

function Peripheral.find(type, func)
    return peripheral.find(type, func)
end
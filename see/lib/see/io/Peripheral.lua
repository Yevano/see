--@native peripheral
--@native unpack

function Peripheral.isPresent(side)
    return peripheral.isPresent(cast(side, "string"))
end

function Peripheral.getType(side)
    return String.new(peripheral.getType(cast(side, "string")))
end

function Peripheral.getMethods(side)
    return Array.new(unpack(peripheral.getMethods(cast(side, "string"))))
end

function Peripheral.call(side, method, ...)
    return peripheral.call(cast(side, "string"), cast(method, "string"), ...)
end
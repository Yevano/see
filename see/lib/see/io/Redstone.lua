--@native redstone

function Redstone.getInput(side)
    return redstone.getInput(cast(side, "string"))
end

function Redstone.setOutput(side, o)
    redstone.setOutput(cast(side, "string"), o)
end

function Redstone.getOutput(side)
    return redstone.getOutput(cast(side, "string"))
end

function Redstone.getAnalogInput(side)
    return redstone.getAnalogInput(cast(side, "string"))
end

function Redstone.setAnalogOutput(side, strength)
    redstone.setAnalogOutput(cast(side, "string"), strength)
end

function Redstone.getAnalogOutput(side)
    return redstone.getAnalogOutput(cast(side, "string"))
end

function Redstone.getBundledInput(side)
    return redstone.getBundledInput(cast(side, "string"))
end

function Redstone.setBundledOutput(side, colors)
    redstone.setBundledOutput(cast(side, "string"), colors)
end

function Redstone.getBundledOutput(side)
    return redstone.getBundledOutput(cast(side, "string"))
end
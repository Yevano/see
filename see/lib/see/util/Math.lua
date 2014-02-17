--@native math

--@import see.util.ArgumentUtils

--[[
    A wrapper of the native Lua math library.
]]

function Math.__static()
    Math.HUGE = math.huge
    Math.PI = math.pi
end

function Math.abs(x)
    ArgumentUtils.check(1, x, "number")
    return math.abs(x)
end

function Math.acos(x)
    ArgumentUtils.check(1, x, "number")
    return math.acos(x)
end

function Math.asin(x)
    ArgumentUtils.check(1, x, "number")
    return math.asin(x)
end

function Math.atan(x)
    ArgumentUtils.check(1, x, "number")
    return math.atan(x)
end

function Math.atan2(y, x)
    ArgumentUtils.check(1, y, "number")
    ArgumentUtils.check(2, x, "number")
    return math.atan2(y, x)
end

function Math.ceil(x)
    ArgumentUtils.check(1, x, "number")
    return math.ceil(x)
end

function Math.cos(x)
    ArgumentUtils.check(1, x, "number")
    return math.cos(x)
end

function Math.cosh(x)
    ArgumentUtils.check(1, x, "number")
    return math.cosh(x)
end

function Math.deg(x)
    ArgumentUtils.check(1, x, "number")
    return math.deg(x)
end

function Math.exp(x)
    ArgumentUtils.check(1, x, "number")
    return math.exp(x)
end

function Math.floor(x)
    ArgumentUtils.check(1, x, "number")
    return math.floor(x)
end

function Math.frexp(x)
    ArgumentUtils.check(1, x, "number")
    return math.frexp(x)
end

function Math.ldexp(m, e)
    ArgumentUtils.check(1, m, "number")
    ArgumentUtils.check(2, e, "number")
    return math.ldexp(m, e)
end

function Math.log(x)
    ArgumentUtils.check(1, x, "number")
    return math.log(x)
end

function Math.log10(x)
    ArgumentUtils.check(1, x, "number")
    return math.log10(x)
end

function Math.max(x, ...)
    local args = {...}
    ArgumentUtils.check(1, x, "number")
    for i = 1, #args do
        ArgumentUtils.check(i + 1, args[i], "number")
    end
    return math.max(x, ...)
end

function Math.min(x, ...)
    local args = {...}
    ArgumentUtils.check(1, x, "number")
    for i = 1, #args do
        ArgumentUtils.check(i + 1, args[i], "number")
    end
    return math.min(x, ...)
end

function Math.modf(x)
    ArgumentUtils.check(1, x, "number")
    return math.modf(x)
end

function Math.pow(x, y)
    ArgumentUtils.check(1, x, "number")
    ArgumentUtils.check(2, y, "number")
    return math.pow(x, y)
end

function Math.rad(x)
    ArgumentUtils.check(1, x, "number")
    return math.rad(x)
end

function Math.random(m, n)
    if m then
        ArgumentUtils.check(1, m, "number")
        if n then
            ArgumentUtils.check(2, n, "number")
            return math.random(m, n)
        end
        return math.random(m)
    end
    return math.random()
end

function Math.randomseed(x)
    ArgumentUtils.check(1, x, "number")
    return math.randomseed(x)
end

function Math.sin(x)
    ArgumentUtils.check(1, x, "number")
    return math.sin(x)
end

function Math.sinh(x)
    ArgumentUtils.check(1, x, "number")
    return math.sinh(x)
end

function Math.sqrt(x)
    ArgumentUtils.check(1, x, "number")
    return math.sqrt(x)
end

function Math.tan(x)
    ArgumentUtils.check(1, x, "number")
    return math.tan(x)
end

function Math.tanh(x)
    ArgumentUtils.check(1, x, "number")
    return math.tanh(x)
end
--@native bit

--@import see.util.ArgumentUtils

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Bit.blshift(n, bits)
	ArgumentUtils.check(1, n, "number")
	ArgumentUtils.check(2, bits, "number")
    return bit.blshift(n, bits)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Bit.brshift(n, bits)
	ArgumentUtils.check(1, n, "number")
	ArgumentUtils.check(2, bits, "number")
    return bit.brshift(n, bits)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Bit.blogicrshift(n, bits)
	ArgumentUtils.check(1, n, "number")
	ArgumentUtils.check(2, bits, "number")
    return bit.blogic_rshift(n, bits)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Bit.bxor(a, b)
	ArgumentUtils.check(1, a, "number")
	ArgumentUtils.check(2, b, "number")
    return bit.bxor(a, b)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Bit.bor(a, b)
	ArgumentUtils.check(1, a, "number")
	ArgumentUtils.check(2, b, "number")
    return bit.bor(a, b)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Bit.band(a, b)
	ArgumentUtils.check(1, a, "number")
	ArgumentUtils.check(2, b, "number")
    return bit.band(a, b)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Bit.bnot(a, b)
	ArgumentUtils.check(1, a, "number")
	ArgumentUtils.check(2, b, "number")
    return bit.bnot(a, b)
end
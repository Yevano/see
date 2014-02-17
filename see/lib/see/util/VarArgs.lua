--@native unpack

--@import see.util.ArgumentUtils

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function VarArgs.unpack(table)
	ArgumentUtils.check(1, table, "table")
    return unpack(table)
end
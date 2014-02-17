--@native table

--@import see.util.ArgumentUtils

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function FastArray.insert(array, ...)
	ArgumentUtils.check(1, array, "table")
    table.insert(array, ...)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function FastArray.remove(array, index)
	ArgumentUtils.check(1, array, "table")
	ArgumentUtils.check(2, index, "number")
    table.remove(array, index)
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function FastArray.sort(array, comp)
	ArgumentUtils.check(1, array, "table")
	ArgumentUtils.check(2, comp, "function")
    table.sort(array, comp)
end
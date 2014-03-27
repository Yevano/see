--@import see.util.Comparator

--@extends see.util.Comparator

--[[
	Return 
	0  - a == b
	-1 - a <  b
	1  - a >  b
]]
function BinaryComparator:compareTo(a, b)
	if a == b then 
		return 0
	elseif a < b then
		return -1
	elseif a > b then
		return 1
	end
end
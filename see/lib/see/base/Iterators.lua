--@native pairs
--@native ipairs

--@import see.util.ArgumentUtils

function Iterators.pairs(t)
    ArgumentUtils.check(1, t, "table")
	return pairs(t)
end

function Iterators.ipairs(t)
    ArgumentUtils.check(1, t, "table")
	return ipairs(t)
end
--@native textutils

--@import see.util.ArgumentUtils

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function URL.encode(str)
	ArgumentUtils.check(1, str, "string")
    str = cast(str, "string")
    return String:new(textutils.urlEncode(str))
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function URL:init(string)
    self.string = cast(string, String)
end

function URL:toString()
    return self.string
end
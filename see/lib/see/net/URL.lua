--@native textutils

--@import see.util.ArgumentUtils

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Url.encode(str)
	ArgumentUtils.check(1, str, "string")
    str = cast(str, "string")
    return String.new(textutils.urlEncode(str))
end

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function Url:init(string)
	ArgumentUtils.check(1, string, "string")
    self.string = cast(string, String)
end

function Url:toString()
    return self.string
end
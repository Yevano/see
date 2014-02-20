--@import see.util.ArgumentUtils

--[[
    Wraps around a native HTTP handle.
    @param handle:handle The native handle.
    @throw see.util.InvalidArgumentException if the args are incorrect.
]]
function HTTPResponse:init(body, responseCode)
	ArgumentUtils.check(1, body, "string")
	ArgumentUtils.check(2, responseCode, "number")
    self.body = cast(body, String)
    self.responseCode = responseCode
end
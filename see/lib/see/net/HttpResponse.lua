--[[
    Wraps around a native HTTP handle.
    @param handle:handle The native handle.
]]
function HttpResponse:init(body, responseCode)
    self.body = cast(body, String)
    self.responseCode = responseCode
end
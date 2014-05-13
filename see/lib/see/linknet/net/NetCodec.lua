function NetCodec.encodeRednetBinary(raw)
    local enc = String:new()
    for i = 1, raw:length() do
        if raw[i] <= 127 then
            enc:add("\0")
            enc:add(String.char(raw[i]))
        else
            enc:add("\1")
            enc:add(String.char(raw[i] - 128))
        end
    end
    return enc
end

function NetCodec.decodeRednetBinary(enc)
    enc = cast(enc, String)
    if enc:length() % 2 == 1 then return end
    local raw = String:new()
    for i = 1, enc:length(), 2 do
        if enc[i] == 0 then
            raw:add(String.char(enc[i + 1]))
        elseif enc[i] == 1 then
            raw:add(String.char(enc[i + 1] + 128))
        else
            return
        end
    end
    return raw
end
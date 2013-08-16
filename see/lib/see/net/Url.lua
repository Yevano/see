--@native textutils

function Url.encode(str)
    str = cast(str, "string")
    return String.new(textutils.urlEncode(str))
end

function Url:init(string)
    self.string = cast(string, String)
end

function Url:toString()
    return self.string
end
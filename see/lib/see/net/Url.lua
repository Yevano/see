function Url:init(string)
    self.string = cast(string, String)
end

function Url:toString()
    return self.string
end
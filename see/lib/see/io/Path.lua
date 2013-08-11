--@native fs

function Path:init(pathString)
    self.pathString = cast(pathString, String)
end

function Path:combine(p)
    return Path.new(String.new(fs.combine(self.pathString, p.pathString)))
end

function Path:getName()
    return String.new(fs.getName(self.pathString))
end

function Path:toString()
    return String.new(self.pathString)
end
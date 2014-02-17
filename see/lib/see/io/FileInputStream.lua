--@native fs.open

--@import see.io.InputStream
--@import see.io.IOException
--@import see.io.Path
--@import see.util.ArgumentUtils

--@extends see.io.InputStream

--[[
    @throw see.util.InvalidArgumentException if the args are incorrect.
]]
function FileInputStream:init(path)
    ArgumentUtils.check(1, path, Path)
    self.handle = fs.open(path.pathString:lstr(), "rb")
end

function FileInputStream:read()
    local ret
    try (function()
        ret = self.handle.read()
    end, function(e)
        throw(IOException.new("Could not read file."))
    end)
    return ret
end

function FileInputStream:flush()
    self.handle.flush()
end

function FileInputStream:close()
    self.handle.close()
end
--@native fs.open

--@import see.io.InputStream
--@import see.io.IOException

--@extends see.io.InputStream

function FileInputStream:init(path)
    self.handle = fs.open(path.pathString:lstr(), "rb")
end

function FileInputStream.__meta:__gc()
    self:close()
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
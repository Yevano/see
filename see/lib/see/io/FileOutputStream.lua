--@native fs.open

--@import see.io.InputStream
--@import see.io.IOException

--@extends see.io.InputStream

function FileOutputStream:init(path)
    self.handle = fs.open(path.pathString:lstr(), "wb")
end

function FileOutputStream.__meta:__gc()
    self:close()
end

function FileOutputStream:write(b)
    try (function()
        self.handle.write(b)
    end, function(e)
        throw(IOException.new("Could not write to file."))
    end)
end

function FileOutputStream:flush()
    self.handle.flush()
end

function FileOutputStream:close()
    self.handle.close()
end
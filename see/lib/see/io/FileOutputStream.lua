--@native fs.open

--@import see.io.InputStream
--@import see.io.IOException
--@import see.io.Path
--@import see.util.ArgumentUtils

--@extends see.io.InputStream

--[[
	@throw see.util.InvalidArgumentException if the args are incorrect.
]]
function FileOutputStream:init(path)
	ArgumentUtils.check(1, path, Path)
    self.handle = fs.open(path.pathString:lstr(), "wb")
end

--[[
    @throw see.util.InvalidArgumentException if the args are incorrect.
]]
function FileOutputStream:write(b)
    try (function()
        self.handle.write(b)
    end, function(e)
        throw(IOException:new("Could not write to file."))
    end)
end

function FileOutputStream:flush()
    self.handle.flush()
end

function FileOutputStream:close()
    self.handle.close()
end
--@import see.rt.ClassLoader
--@import see.rt.DefaultClassLoader

--@native fs
--@native loadstring

--@extends see.rt.DefaultClassLoader

--[[
    Load a class from an archive
    @param string the archive bytes
    @param string the path of the class
    @param string name of the class
]]
function ArchiveClassLoader:loadClass(archiveBytes, path, name)
    local loc = archiveBytes:find("F" .. path .. "\0", 1, true)
    if not loc then
        return nil, "Could not find class " .. name .. " in archive path " .. path .. "."
    end
    loc = loc + #path + 2
    local fin = archiveBytes:find("\0", loc) - 1
    local code = archiveBytes:sub(loc, fin)

    -- Setup class execution environment
    local def, err = loadstring(code, name)
    if not def then
        return nil, err
    end
    return self:super(DefaultClassLoader).loadClass(def, ClassLoader.getAnnotations(code), name)	
end
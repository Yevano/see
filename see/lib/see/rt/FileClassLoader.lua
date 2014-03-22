--@import see.rt.ClassLoader
--@import see.rt.DefaultClassLoader

--@native fs
--@native loadstring

--@extends see.rt.DefaultClassLoader

function FileClassLoader:loadClass(path, name)
	local fileHandle = fs.open(path, "r")
    if not fileHandle then
        return nil, "Could not read file."
    end
    local code = fileHandle.readAll()
    fileHandle.close()

    -- Setup class execution environment
    local def, err = loadstring(code, name)
    if not def then
        return nil, "Could not load class."
    end

    return self:super(DefaultClassLoader).loadClass(def, ClassLoader.getAnnotations(code), name)
end
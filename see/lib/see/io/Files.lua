--@native fs
--@native unpack

--@import see.io.IOException

function Files.list(path)
    return Array:new(unpack(fs.list(path.pathString:lstr())))
end

function Files.exists(path)
    return fs.exists(path.pathString:lstr())
end

function Files.isDir(path)
    return fs.isDir(path.pathString:lstr())
end

function Files.isReadOnly(path)
    return fs.isReadOnly(path.pathString:lstr())
end

function Files.getDrive(path)
    local drive = fs.getDrive(path.pathString:lstr())
    return drive and String:new(drive) or nil
end

function Files.getSize(path)
    return fs.getSize(path.pathString:lstr())
end

function Files.getFreeSpace(path)
    return fs.getFreeSpace(path.pathString:lstr())
end

function Files.makeDir(path)
    fs.makeDir(path.pathString:lstr())
end

function Files.move(src, dst)
    fs.move(src.pathString:lstr(), dst.pathString:lstr())
end

function Files.copy(src, dst)
    fs.copy(src.pathString:lstr(), dst.pathString:lstr())
end

function Files.delete(path)
    fs.delete(path.pathString:lstr())
end

function Files.readAll(path)
    local handle, err = fs.open(path.pathString:lstr(), "r")

    if not handle then
        handle.close()
        throw(IOException:new("Could not open file (" .. path.pathString .. "): " .. err))
    else
        local ret = cast(handle.readAll(), String)
        handle.close()
        return ret
    end
end
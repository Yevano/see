--@native print
--@native read
--@native write
--@native unpack
--@native shell
--@native os

--@import see.base.String
--@import see.io.Path
--@import see.util.Properties
--@import see.rt.SecurityManager

--[[
    A utility class for useful system operations.
]]

local systemProperties = nil
local securityManager = nil

function System.__static()
    systemProperties = Properties:new()
    securityManager = SecurityManager:new()
end

--[[
    Gets a system property
    @param see.base.String key 
    @return see.base.String the value of the system property
]]
function System.getProperty(key)
    return systemProperties:getProperty(key)
end

--[[
    Sets a system property
    @param see.base.String key
    @param see.base.String value
]]
function System.setProperty(key, value)
    systemProperties:setProperty(key, value)
end

--[[
    Gets the system security manager
    @return see.rt.SecurityManager 
]]
function System.getSecurityManager()
    return securityManager
end

--[[
    Reads a line from the shell.
    @return see.base.String The line that was read.
]]
function System.read()
    return cast(read(), String)
end

--[[
    Prints a line to the shell.
    @param see.base.String... The lines to print.
]]
function System.print(...)
    local args = {...}
    for i = 1, #args do
        args[i] = cast(args[i], "string")
    end
    print(unpack(args))
end

--[[
    Writes a string to the shell.
    @param see.base.String... The strings to write.
]]
function System.write(...)
    local args = {...}
    for i = 1, #args do
        args[i] = cast(args[i], "string")
    end
    write(unpack(args))
end

--[[
    Loads a native API into a given table.
    @param see.io.Path:path The path to load from.
    @return table The API table.
]]
function System.loadNativeAPI(path)
    local g = { }
    local function f()
        os.loadAPI(path.pathString:lstr())
    end
    setfenv(f, g)
    f()
    return g[path:getName():lstr()]
end

--[[
    Resolves a path relative to the the working directory.
    @param see.io.Path:path The path to resolve.
    @return see.io.Path The absolute path.
]]
function System.resolve(path)
    return Path:new(shell.resolve(path.pathString:lstr()))
end

--[[
    Run a command in shell
]]
function System.run(cmd)
    shell.run(cast(cmd, "string"))
end

--[[
    Get this computer's ID
]]
function System.getID()
    return os.getComputerID()
end

--[[
    Get the system clock value
]]
function System.clock()
    return os.clock()
end

--[[
    Get the system time value
]]
function System.time()
    return os.time()
end
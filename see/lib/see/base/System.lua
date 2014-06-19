--@native print
--@native write
--@native unpack
--@native shell
--@native os
--@native keys

--@import see.base.String
--@import see.event.Events
--@import see.event.impl.CharEvent
--@import see.event.impl.KeyPressEvent
--@import see.event.impl.PasteEvent
--@import see.event.impl.TerminalResizeEvent
--@import see.io.Terminal
--@import see.io.Path
--@import see.util.Math
--@import see.util.Properties

--[[
    A utility class for useful system operations.
]]

local systemProperties

function System.__static()
    systemProperties = Properties:new()
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
    Reads a line from the shell.
    @param see.base.String The character that will be printed instead.
    @param table The history of previous entries.
    @return see.base.String The line that was read.
]]
function System.read(replaceChar, history)
    Terminal.setCursorBlink(true)

    local line = String:new("")
    local historyPos
    local pos = 0

    if replaceChar then
        replaceChar = cast(replaceChar, String):sub(1, 1)
    end
    
    local w = Terminal.getSize().x
    local sx = Terminal.getPos().x
    
    local function redraw(customReplaceChar)
        local scroll = 0
        if sx + pos >= w then
            scroll = (sx + pos) - w
        end

        local cpos = Terminal.getPos()
        Terminal.setPos(sx, cpos.y)

        local replace = customReplaceChar or replaceChar
        if replace then
            Terminal.write(replace:duplicate(Math.max(line:length() - scroll, 0)))
        elseif line:length() > 0 then
            Terminal.write(line:sub(scroll + 1))
        end
        Terminal.setPos(sx + pos - scroll, cpos.y)
    end
    
    while true do        
        local event = Events.pull(CharEvent, PasteEvent, KeyPressEvent, TerminalResizeEvent)
        if event.ident == "char" then
            -- Typed key
            line:insert(pos + 1, event.char)
            pos = pos + 1
            redraw()

        elseif event.ident == "paste" then
            -- Pasted text
            local insertText = cast(event.text, String)
            line:insert(pos + 1, insertText)

            pos = pos + insertText:length()
            redraw()

        elseif event.ident == "key" then
            if event.key == keys.enter then
                -- Enter
                break
                
            elseif event.key == keys.left then
                -- Left
                if pos > 0 then
                    pos = pos - 1
                    redraw()
                end
                
            elseif event.key == keys.right then
                -- Right                
                if pos < line:length() then
                    redraw(" ")
                    pos = pos + 1
                    redraw()
                end
            
            elseif event.key == keys.up or event.key == keys.down then
                -- Up or down
                if history then
                    redraw(STR(" "))
                    if event.key == keys.up then
                        -- Up
                        if historyPos == nil then
                            if #history > 0 then
                                historyPos = #history
                            end
                        elseif historyPos > 1 then
                            historyPos = historyPos - 1
                        end
                    else
                        -- Down
                        if historyPos == #history then
                            historyPos = nil
                        elseif historyPos ~= nil then
                            historyPos = historyPos + 1
                        end                        
                    end
                    if historyPos then
                        line = cast(history[historyPos], String)
                        pos = line:length()
                    else
                        line = String:new("")
                        pos = 0
                    end
                    redraw()
                end
            elseif event.key == keys.backspace then
                -- Backspace
                if pos > 0 then
                    redraw(STR(" "))
                    line:remove(pos, 1)
                    pos = pos - 1                 
                    redraw()
                end
            elseif event.key == keys.home then
                -- Home
                redraw(STR(" "))
                pos = 0
                redraw()        
            elseif event.key == keys.delete then
                -- Delete
                if pos < line:length() then
                    redraw(STR(" "))
                    line:remove(pos+1, 1)
                    redraw()
                end
            elseif event.key == keys["end"] then
                -- End
                redraw(STR(" "))
                pos = line:length()
                redraw()
            end

        elseif event.ident == "term_resize" then
            -- Terminal resized
            w = Terminal.getSize().x
            redraw()

        end
    end

    local cy = Terminal.getPos().y
    Terminal.setCursorBlink(false)
    Terminal.setPos( w + 1, cy )
    System.print()
    
    return line
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
        write(cast(args[i], "string"))
    end
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
--@native term

function Terminal.setFG(color)
    term.setTextColor(color)
end

function Terminal.setBG(color)
    term.setBackgroundColor(color)
end

function Terminal.write(string)
    term.write(cast(string, "string"))
end

function Terminal.clear()
    term.clear()
end

function Terminal.clearLine()
    term.clearLine()
end

function Terminal.getSize()
    local x, y = term.getSize()
    return {x = x, y = y}
end

function Terminal.setCursorBlink(blink)
    term.setCursorBlink(blink)
end

function Terminal.redirect(object)
    return term.redirect(object)
end

function Terminal.current()
    return term.current()
end

function Terminal.setPos(x, y)
    term.setCursorPos(x, y)
end

function Terminal.getPos()
    local x, y = term.getCursorPos()
    return {x = x, y = y}
end

function Terminal.isColor()
    return term.isColor()
end

function Terminal.isColour()
    return term.isColour()
end
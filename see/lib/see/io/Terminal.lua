--@native term

function Terminal.setFG(color)
    term.setTextColor(color)
end

function Terminal.setBG(color)
    term.setBackgroundColor(color)
end

function Terminal.write(string)
    term.write(string)
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

function Terminal.redirect(monitor)
    term.redirect(monitor)
end

function Terminal.restore()
    term.restore()
end

function Terminal.setTextScale(scale)
    term.setTextScale(scale)
end

function Terminal.setPos(x, y)
    term.setCursorPos(x, y)
end

function Terminal.getPos()
    local x, y = term.getCursorPos()
    return {x = x, y = y}
end
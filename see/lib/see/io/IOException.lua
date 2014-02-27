--@import see.base.Exception

--@extends see.base.Exception

function IOException:init(message)
    self:super(Exception).init(message)
end
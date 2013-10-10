--@import see.base.Exception

--@extends see.base.Exception

function IOException:init(message)
    Exception.init(self, message)
end
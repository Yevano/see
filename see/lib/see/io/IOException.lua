--@import see.base.Exception

--@extends see.base.Exception

function IOException(message)
    Exception.init(self, message)
end
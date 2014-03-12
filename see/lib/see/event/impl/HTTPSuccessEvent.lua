--@import see.event.Event
--@import see.net.HTTPResponse

--@extends see.event.Event

function HTTPSuccessEvent:init(url, responseHandle)
	self:super(Event).init("http_success")
	self.url = url
	self.response = HTTPResponse:new(responseHandle.readAll(), responseHandle.getResponseCode())
	responseHandle.close()
end
--@import see.event.Event
--@import see.net.HttpResponse

function HttpSuccessEvent:init(url, responseHandle)
	Event.init(self, "http_success")
	self.url = url
	self.response = HttpResponse.new(responseHandle.getAll(), responseHandle.getResponseCode())
	responseHandle.close()
end
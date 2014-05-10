--@import see.io.DataOutputStream
--@import see.rt.InvalidArgumentException

--@native pairs
--@native print

function Properties:init()
	self.props = {}
end

function Properties:setProperty(key, value) 
	if key == nil then throw(InvalidArgumentException:new("key must not be nil")) end
	if value == nil then throw(InvalidArgumentException:new("value must not be nil")) end
	key = cast(key, "string")
	value = cast(value, "string")
	self.props[key] = value
end

function Properties:getProperty(key)
	if key == nil then throw(InvalidArgumentException:new("key must not be nil")) end
	key = cast(key, "string")
	return STR(self.props[key])
end

function Properties:load(text) --todo use an inputStream
	self.props = {}

	text = cast(text, String)

	local lines = text:split("\n")
	for line in lines:iAll() do
		local kvp = line:split("=")
		local key = kvp[1]
		local value = kvp[2]

		key = cast(key, "string")
		value = cast(value, "string")

		self:setProperty(key, value)
	end
end

function Properties:save(outputStream)
	local dout = DataOutputStream:new(outputStream)

	for k, v in pairs(self.props) do
		dout:writeString(k .. "=" .. v .. "\n")
	end

	dout:flush()
	dout:close()
end
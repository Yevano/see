--@native string.find

--[[
	Used to match substrings of a string to a particular pattern.
]]

--[[
	Constructs a matcher with the given pattern.
	@param string:pattern Pattern to match.
]]
function Matcher:init(pattern, str)
	self.pattern = cast(pattern, "string")
	self.string = cast(str, "string")
end

function Matcher:find()
	self.left, self.right = self.string:find(pattern, (self.right or 0) + 1)
	return self.left and true or false
end

function Matcher:matched()
	return String.new(str:sub(self.left, self.right))
end
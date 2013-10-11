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
	if self.right and self.right + 1 > #self.string then
		return false
	end
	self.left, self.right = self.string:find(self.pattern, (self.right or 0) + 1)
	return self.left and true or false
end

function Matcher:matched()
	return String.new(self.string:sub(self.left, self.right))
end
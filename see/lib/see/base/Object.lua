--@native tostring
--@native pairs
--@native setmetatable
--@native getmetatable
--@import see.base.String

--[[
	The super class for all classes loaded in the See Runtime.
]]

--[[
	Fully copies an object.
	@return see.base.Object The copied object.
]]
function Object:copy()
	local ret = { }
	for k, v in pairs(self) do
		ret[k] = v
	end
	setmetatable(ret, getmetatable(self))
	return ret
end

--[[
	Return the full class name of this Object.
	@return string The class name.
]]
function Object:getClass()
	return self.__type
end

function Object:toString()
	return String.new(tostring(self) .. ":" .. self:getClass().__name)
end

-- TODO: Fix me.
function Object.__concat(l, r)
	return cast(l, String):concat(cast(r, String))
end
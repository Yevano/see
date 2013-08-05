--@import see.example.Helper
--@extends see.example.Helper

function WellHelper:init(size, name)
	Helper.init(self, name)
	self.size = size
end

function WellHelper:help()
	System.print("Saving " .. self.name .. " from a " .. self.size .. " well...")
end
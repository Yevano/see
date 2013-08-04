function Helper:init(name)
	self.name = name
end

function Helper:help()
	System.print("Helping " .. name "...")
end
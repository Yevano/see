--@import see.example.WellHelper

function Test.main(args)
	System.print("Going to help " .. args[1] .. ".")
	local helper = WellHelper.new("big", args[1])
	helper:help()
end
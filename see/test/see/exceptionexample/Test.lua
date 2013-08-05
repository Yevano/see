function Test.main(args)
	try (function()
		System.print("Running some error-prone code...")
		notarealfunction()
	end, function(e)
		System.print(STR"There was an exception! " .. e.message)
	end)
end
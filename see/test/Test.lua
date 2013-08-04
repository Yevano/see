--@import see.concurrent.Thread

function Test.main(args)
	local stringList = Array.new("yoyoyo", "123", "whaoha", "hello", "superawesome", "lua")

	local t1 = Thread.new(function(i)
		while true do
			i = Thread.yield(#stringList[i])
		end
	end)
	local t2 = Thread.new(function(i)
		while true do
			i = Thread.yield(#stringList[i])
		end
	end)

	for i = 1, stringList.length, 2 do
		local _, s = t1:resume(i)
		System.print(s)
		_, s = t2:resume(i + 1)
		System.print(s)
	end
end
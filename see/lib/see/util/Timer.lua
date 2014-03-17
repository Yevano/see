--@import see.concurrent.Thread

local timerThread
local running

function Timer.__static()
	timerThread = Thread:new(function()

	end)
end

function Timer:init()

end
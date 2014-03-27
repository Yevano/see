--@import see.concurrent.Thread
--@import see.event.impl.TimerEvent

--@native os.startTimer

local timerThread
local timers
local init = false

--[[
	Create the timer update thread
]]
function Timer.__static()
	timers = { }
	timerThread = Thread:new(function()
		while true do
			local evt = Events.pull(TimerEvent)
			local timer = timers[evt.id]

			if timer then
				timer.func()

				if timers[evt.id]._repeat then
					timers[evt.id] = nil
					timer.timerID = os.startTimer(timer.delay)
					timers[timer.timerID] = timer
				else
					timers[evt.id] = nil
				end
			end
		end
	end)
	timerThread:setDaemon()
end

--[[
	Creates a new timer
	@param number delay
	@param number the funciton to call
	@param boolean timer repeat
]]
function Timer:init(delay, func, _repeat)
	self.delay = delay
	self.func = func
	self._repeat = true
	if _repeat ~= nil then
		self._repeat = _repeat
	end
end

--[[
	Start the timer
]]
function Timer:start()
	if not init then
		init = true
		timerThread:start()
	end

	self.timerID = os.startTimer(self.delay)
	if not timers[self.timerID] then
		timers[self.timerID] = self
	end
end

--[[
	Stop the timer
]]
function Timer:stop()
	if timers[self.timerID] then
		timers[self.timerID] = nil
	end
end
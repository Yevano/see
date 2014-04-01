--@import see.util.ArgumentUtils

--@native pairs
--@native table

--[[
	Creates a new LRU cache
	@param number max size of the cache (unlimited if nil)
	@param number expire time (unlimited if nil)
	@param function entry evict callback (params key,value)
]]
function LRUCache:init(size, expire, entryEvicted)
	if size then ArgumentUtils.check(1, size, "number") end
	if expire then ArgumentUtils.check(2, expire, "number") end

	self.size = size
	self.expire = expire
	self.entryEvicted = entryEvicted

	self.sets = 0
	self.hits = 0
	self.misses = 0
	self.evicts = 0

	self.values = { }
	self.expireTimes = { }
	self.accessTimes = { }
end

--[[
	Sets a key to a value
	@param any the key
	@param any the value
	@param number custom expire time for this key, uses cache's default expire time if nil
]]
function LRUCache:set(key, value, expireTime)
	if expireTime then ArgumentUtils.check(1, expireTime, "number") end

	self.sets = self.sets + 1

	local t = System.clock()
	self.values[key] = value
	if expireTime then
		self.expireTimes[key] = t + expireTime
	else
		self.expireTimes[key] = t + self.expire
	end
	self.accessTimes[key] = t
	self:cleanup()
end

--[[
	Get the value of a key in the cache
	@param any the key
]]
function LRUCache:get(key)
	local t = System.clock()
	self:cleanup()
	if self.values[key] then
		self.hits = self.hits + 1
		self.accessTimes[key] = t
		return self.values[key]
	end

	self.misses = self.misses + 1
	return nil
end	

--[[
	Remove a value in the cache
	@param any the key
]]
function LRUCache:remove(key)
	self.values[key] = nil
	self.expireTimes[key] = nil
	self.accessTimes[key] = nil
end

--[[
	Removes any values that have expired and removes least recently used values until size < max size
]]
function LRUCache:cleanup()
	if self.expire ~= nil then
		local remove = { }

		local t = System.clock()
		for k, v in pairs(self.expireTimes) do
			if v < t then remove[k] = true end
		end

		for k in pairs(remove) do
			if self.entryEvicted then
				self.entryEvicted(k, self.values[k])
			end

			self.evicts = self.evicts + 1
			self:remove(k)
		end
	end

	local function sort(t)
		local array = { }
		for k, v in pairs(t) do
			table.insert(array, {key = k, access = v})
		end
		table.sort(array, function(a, b) return a.access < b.access end)
		return array
	end

	if self.size ~= nil then
		local sorted = sort(self.accessTimes)

		while self:length() > self.size do
			local oldest = sorted[1]

			self.evicts = self.evicts + 1

			if self.entryEvicted then
				self.entryEvicted(oldest.key, self.values[oldest.key])
			end

			self:remove(oldest.key)
		end
	end
end

--[[
	Returns the current size of the cache
]]
function LRUCache:length()
	local count = 0
	for _ in pairs(self.values) do count = count + 1 end
	return count
end

--[[
	Reset and clear the cache
]]
function LRUCache:reset()
	self.sets = 0
	self.hits = 0
	self.misses = 0
	self.evicts = 0

	self.values = { }
	self.expireTimes = { }
	self.accessTimes = { }
end

--[[
	Returns the current number of hits
]]
function LRUCache:getHits()
	return self.hits
end

--[[
	Returns the current number of misses
]]
function LRUCache:getMisses()
	return self.misses
end

--[[
	Returns the current number of sets
]]
function LRUCache:getSets()
	return self.sets
end

--[[
	Returns the current number of evicts
]]
function LRUCache:getEvicts()
	return self.evicts
end
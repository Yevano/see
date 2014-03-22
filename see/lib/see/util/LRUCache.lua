--@import see.util.ArgumentUtils

--@native pairs
--@native table

function LRUCache:init(size, expire, entryEvicted)
	if size then ArgumentUtils.check(1, size, "number") end
	if expire then ArgumentUtils.check(2, expire, "number") end

	self.size = size
	self.expire = expire
	self.entryEvicted = entryEvicted

	self.puts = 0
	self.hits = 0
	self.misses = 0
	self.evicts = 0

	self.values = { }
	self.expireTimes = { }
	self.accessTimes = { }
end

function LRUCache:set(key, value, expireTime)
	if expireTime then ArgumentUtils.check(1, expireTime, "number") end

	self.puts = self.puts + 1

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

function LRUCache:remove(key)
	self.values[key] = nil
	self.expireTimes[key] = nil
	self.accessTimes[key] = nil
end

function LRUCache:cleanup()
	if self.expire ~= nil then
		local remove = { }

		local t = System.clock()
		for k, v in pairs(self.expireTimes) do
			if v < t then remove[k] = true end
		end

		for k in pairs(remove) do
			if self.entryEvicted then
				self.entryEvicted(oldest.key, self.values[oldest.key])
			end

			self:remove(k)
		end
	end

	if self.size ~= nil then
		local sorted = self:sort(self.accessTimes)

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

function LRUCache:sort(t)
	ArgumentUtils.check(1, t, "table")
	local array = { }
	for k, v in pairs(t) do
		table.insert(array, {key = k, access = v})
	end
	table.sort(array, function(a, b) return a.access < b.access end)
	return array
end

function LRUCache:length()
	local count = 0
	for _ in pairs(self.values) do count = count + 1 end
	return count
end

function LRUCache:reset()
	self.puts = 0
	self.hits = 0
	self.misses = 0
	self.evicts = 0

	self.values = { }
	self.expireTimes = { }
	self.accessTimes = { }
end

function LRUCache:getHits()
	return self.hits
end

function LRUCache:getMisses()
	return self.misses
end

function LRUCache:getPuts()
	return self.puts
end

function LRUCache:getEvicts()
	return self.evicts
end
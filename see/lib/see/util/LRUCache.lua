--@native pairs
--@native table

function LRUCache:init(size, expire)
	self.size = size
	self.expire = expire

	self.values = { }
	self.expireTimes = { }
	self.accessTimes = { }
end

function LRUCache:set(key, value)
	local t = System.clock()
	self.values[key] = value
	self.expireTimes[key] = t + self.expire
	self.accessTimes[key] = t
	self:cleanup()
end

function LRUCache:get(key)
	local t = System.clock()
	self:cleanup()
	if self.values[key] then
		self.accessTimes[key] = t
		return self.values[key]
	end
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
			self:remove(k)
		end
	end

	if self.size == nil then
		return
	end

	local sorted = self:sort(self.accessTimes)

	while self:length() > self.size do
		local oldest = sorted[1]
		self:remove(oldest.key)
	end
end

function LRUCache:sort(t)
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
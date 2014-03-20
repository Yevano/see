--@import see.util.Math
--@import see.util.BinaryComparator

function BinaryHeap:init(comp)
	self.comp = comp
	if not self.comp then
		self.comp = BinaryComparator:new()
	end
	self.array = { }
	self.size = 0
end

function BinaryHeap:add(value)
	self.size = self.size + 1
	self.array[self.size] = value
	
	self:bubbleUp()
end

function BinaryHeap:peek()
	return self.array[1]
end

function BinaryHeap:remove()
	local value = self:peek()

	self.array[1] = self.array[self.size]
	self.array[self.size] = nil
	self.size = self.size - 1

	self:bubbleDown()

	return value
end

function BinaryHeap:length()
	return #self.array
end

function BinaryHeap:isEmpty()
	return self:length() == 0
end

function BinaryHeap:bubbleDown()
	local index = 1

	while self:hasLeftChild(index) do
		local smallerChild = self:leftIndex(index)

		if self:hasRightChild(index) and self.comp:compareTo(self.array[self:leftIndex(index)], self.array[self:rightIndex(index)]) > 0 then
			smallerChild = self:rightIndex(index)
		end

		if self.comp:compareTo(self.array[index], self.array[smallerChild]) > 0 then
			self:swap(index, smallerChild)
		else
			break
		end

		index = smallerChild
  	end
end

function BinaryHeap:bubbleUp()
	local index = self.size

	while self:hasParent(index) and self.comp:compareTo(self:parent(index), self.array[index]) > 0 do
		self:swap(index, self:parentIndex(index))
		index = self:parentIndex(index)
	end
end

function BinaryHeap:hasParent(i)
	return i > 1
end

function BinaryHeap:leftIndex(i)
	return i * 2
end

function BinaryHeap:rightIndex(i)
	return i * 2 + 1
end

function BinaryHeap:hasLeftChild(i)
	return self:leftIndex(i) <= self.size
end

function BinaryHeap:hasRightChild(i)
	return self:rightIndex(i) <= self.size
end

function BinaryHeap:parent(i)
	return self.array[self:parentIndex(i)]
end

function BinaryHeap:parentIndex(i)
	return Math.floor(i / 2)
end

function BinaryHeap:swap(a, b)
	local tmp = self.array[a]
	self.array[a] = self.array[b]
	self.array[b] = tmp
end

function BinaryHeap:rebuild()
	local tmpArray = { }
	local length = self:length()

	for i = 1, length do
		tmpArray[i] = self:remove()
	end

	self.array = { }
	self.size = 0

	for i = 1, length do
		self:add(tmpArray[i])
	end
end
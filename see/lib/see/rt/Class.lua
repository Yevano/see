function Class:getName()
	return String.new(self.__name)
end

function Class:toString()
	return self:getName()
end
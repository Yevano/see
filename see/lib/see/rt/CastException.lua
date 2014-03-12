--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function CastException:init(valueType, castType)
	self:super(RuntimeException).init(STR(
		"Failed to cast value of type ",
		isprimitive(valueType) and valueType or valueType:getName(),
		" to ",
		isprimitive(castType) and castType or castType:getName(), "."))
end
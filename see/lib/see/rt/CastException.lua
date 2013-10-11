--@import see.rt.RuntimeException

--@extends see.rt.RuntimeException

function CastException:init(valueType, castType)
	RuntimeException.init(self, STR(
		"Failed to cast value of type ",
		isprimitive(valueType) and valueType or valueType.__name,
		" to ",
		isprimitive(castType) and castType or castType.__name, "."))
end
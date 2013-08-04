--@native print
--@native read

--[[
	A utility class for useful system operations.
]]

--[[
	Reads a line from the shell.
	@return see.base.String The line that was read.
]]
function System.read(str)
	return cast(read(), String)
end

--[[
	Prints a line to the shell.
	@param see.base.String The line to print.
]]
function System.print(...)
	local args = {...}
	for i = 1, #args do
		args[i] = cast(str, "string")
	end
	print(...)
end

function System.loadNativeAPI(path)
	os.loadAPI()
end

function System.unloadNativeAPI(path)
	os.unloadAPI(path)
end
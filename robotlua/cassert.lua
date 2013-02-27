local assert = assert

NUMBER = "number"
STRING = "string"
BOOL = "boolean"
FUNCTION = "function"
TABLE = "table"
THREAD = "thread"
USERDATA = "userdata"

function cassert(arg, ...)
	local args = {...}
	local types = table.concat(args, "/")
	for k,v in pairs(args) do	
		if (type(arg)==v) then return true end
	end
	print(debug.traceback())
	error("Expected "..types..", got "+type(arg)..".", 3)
	return false
end
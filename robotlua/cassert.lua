local assert = assert

NUMBER = "number"
FUNCTION = "function"
STRING = "string"
BOOL = "boolean"
TABLE = "table"
THREAD = "thread"

function cassert(arg, vtype)
	if (type(arg)==vtype) then return true end
	print(debug.traceback())
	error("Expected "..vtype..", got "+type(arg)..".", 3)
	return false
end

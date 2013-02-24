module(..., package.seeall)

local hooks = {}

-- register
-- Adds a new hook to the global table so it can be broadcast.
-- Returns whether a new hook was registered (same name cannot be registered twice)
function register(hookName)
	if (hooks[hookName]) return false end
	hooks[hookName] = {}
	return true
end

-- unregister
-- Removes a hook from the global table so it cannot be broadcast anymore.
-- Returns whether or not the hook existed and was unregistered.
function unregister(hookName)
	if (not (hook[hookName]==nil)) then
		hooks[hookName] = nil
		return true
	end
	return false
end

-- add
-- Hooks a function in with a custom function name to a global hook
-- Function will be called whenever the global hook is broadcast.
-- Custom hook name is to allow hooks to be overridden and removed.
-- returns false if the hookName is not registered
function add(hookName, customHookName, callBackFunc)
	if (hooks[hookName]) then
		hooks[hookName].customHookName = callBackFunc
	end
end


-- remove
-- Unhooks the function with a specific customHookName
-- Returns whether or not the hook existed and was removed.
function remove(hookName, customHookName)
	if (hooks[hookName] && hooks[hookName]) then
		hooks[hookName].customHookName = nil
		return true
	end
	return false
end

-- broadcast
-- Calls all functions hooked to hookName with {args}
function broadcast(hookName, ...)
	for k,v in pairs(hooks[hookName]) do
		v(...)
	end
	return true
end

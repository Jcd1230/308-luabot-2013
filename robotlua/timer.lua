require('hook')

module(..., package.seeall)


local timers = {}
function new(name, delay, repeating, func)

	timers[name] = {}
	timers[name][1] = delay + os.clock()
	timers[name][2] = repeating and delay or -1
	timers[name][3] = func

end

function update()
	for k,v in pairs(timers) do
		if (os.clock() >= v[1]) then
			if (v[2] > 0) then
				timers[k][1] = timers[k][2]+os.clock()
				v[3]()
			else
				v[3]()
				timers[k] = nil
			end
		end
	end
end
hook.add("TeleOpPeriodic", "__TimerUpdateT", update)
hook.add("AutonomousPeriodic", "__TimerUpdateA", update)
--hook.add("DisabledPeriodic", "__TimerUpdateD", update) --TODO: Should this be in or not?
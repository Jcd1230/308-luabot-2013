
local timers = {}
function timer(name, delay, repeating, func)

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

function run()
	while(true) do
		update()
	end
end


timer("test1", 1.25, true, function() print("test") timer("test1", 3, false, function() print("remade lolwat") end) end)
timer("test2", 3, false, function() print("single shot") end)
timer(5.3, 5, false, function() end)
run()
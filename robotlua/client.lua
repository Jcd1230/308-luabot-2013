
require('hook')
hook.register("DashAngle")

local dashClient = wpilib.DashboardClient("10.3.8.5","dashDataReceived")

module(...,package.seeall)

function dashDataReceived(header, data)
	print("Received data: \n"..header.."\n"..data)
	if (header == 'l') then
		local success, err = pcall(loadstring,data)
		if (not success) then
			print(err)
		end
		return
	end
	
	if (header == 'a') then
		local angle = tonumber(data)
		if (type(angle)=="number") then
			hook.broadcast("DashAngle", angle)
		end
		return
	end

end
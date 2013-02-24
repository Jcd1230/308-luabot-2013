hook = require('hook')

dashClient = wpilib.DashboardClient("10.3.8.5","dashDataReceived")

function dashDataReceived(header, data)
	print("Received data: \n"..header.."\n"..data)
end
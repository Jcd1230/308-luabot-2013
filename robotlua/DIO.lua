
module(...,package.seeall)

local hook = require('hook')
local IN = false
local OUT = true
local DIOModule
local function setupDIO()
	DIOModule =  = wpilib.DigitalModule.GetInstance(1)
end

function get()
	return DIOModule
end

function SetupPIN(channel, isinput)
		--Direction is 0 input || 1 output
	if (DIOModule:GetDIODirection(channel)==isinput) then
		DIOModule:


hook.add("RobotInit", "InitDIO", setupDIO)


		
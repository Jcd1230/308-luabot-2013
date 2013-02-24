
module(...,package.seeall)

local hook = require('hook')

local Solenoids = {}
local SolValues = {}

local function setupSolenoids()
	for i = 1,8 do
		Solenoids.i = wpilib.Solenoid(i)
		SolValues.i = false
	end
end
hook.add("RobotInit", "InitSolenoidSetup", setupSolenoids)

function set(n, val)
	Solenoids[n]:Set(val)
	SolValues[n] = true
end

function get(n)
	return SolValues[n]
end
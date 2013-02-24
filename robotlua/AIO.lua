
module(...,package.seeall)

local hook = require('hook')

local AnalogModule = wpilib.AnalogModule.GetInstance(1)

local function setupAIO()
end
hook.add("RobotInit", "InitAIO", setupAIO)


		
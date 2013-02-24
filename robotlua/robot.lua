--
-- robot.lua
--

module(...,package.seeall)

dofile('client.lua')
dofile('io.lua')
--dofile('SUBSYSTEM_HERE')

local hook = require('hook')

local solenoid = require('Solenoid')
local AIO = require('AIO')
local DIO = require('DIO')

hook.register("RobotInit")
hook.register("TeleOpInit")
hook.register("AutonomousInit")
hook.register("DisabledInit")
hook.register("TeleOpPeriodic")
hook.register("AutonomousPeriodic")
hook.register("DisabledPeriodic")


-- samples/template/robot.lua - Boilerplate code to get robot running

function run()
    -- Main loop
	robotinit()
    while true do
        if wpilib.IsDisabled() then
            disabled()
            repeat wpilib.Wait(0.01) until not wpilib.IsDisabled()
        elseif wpilib.IsAutonomous() then
            autonomous()
            repeat wpilib.Wait(0.01) until not wpilib.IsAutonomous() or not wpilib.IsEnabled()
        else
            teleop()
            repeat wpilib.Wait(0.01) until not wpilib.IsOperatorControl() or not wpilib.IsEnabled()
        end
    end
end

function robotinit()
	hook.broadcast("RobotInit")
end

function teleop()
	hook.broadcast("TeleOpInit")
    while wpilib.IsOperatorControl() and wpilib.IsEnabled() do
        hook.broadcast("TeleOpPeriodic")
        wpilib.Wait(0.01)
    end
end

function autonomous()
	hook.broadcast("AutonomousInit")
    while (wpilib.IsAutonomous() and wpilib.IsEnabled()) do
		hook.broadcast("AutonomousPeriodic");
		wpilib.Wait(0.01)
	end
end

function disabled()
	hook.broadcast("DisabledInit")
	while (wpilib.IsDisabled()) do
		hook.broadcast("DisabledPeriodic")
		wpilib.Wait(0.01)
	end

end

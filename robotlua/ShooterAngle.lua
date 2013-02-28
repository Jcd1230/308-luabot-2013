
local A_ = {
	P = 0.175,
	I = 0.0,
	D = 0.01
	}
	
local potAngle = {
	min = 2.7,
	max = 1.1,
	angleMin = 9,
	angleMax = 39
	}

local APIDMotorFake
local AnglePID
local AngleMotor
local AnglePot

local motorTol = 0.2

function AtoV(angle)
	return --get whacky formula
end

function ShooterAngleInit()
	APIDMotorFake = wpilib.SpeedController()

	AnglePot = wpilib.AnalogChannel(POT_SHOOTERANGLE)
	AngleMotor = wpilib.Victor(VIC_ANGLEMOTOR)
	AnglePID = wpilib.PIDController(A_.P, A_.I, A_.D, AnglePot, APIDMotorFake)
	AnglePID:SetInputRange(potAngle.min, potAngle.max)
	
end
hook.add("RobotInit","ShooterAngleInit",ShooterAngleInit)

function UpdateShooterMotor()
	if (AnglePID:Get() > motorTol) then
		AngleMotor:Set(AnglePID:Get())
	else
		AngleMotor:Set(0)
	end
end
hook.add("AutonomousPeriodic", "UpdateSAngle(A)", UpdateShooterMotor)
hook.add("TeleOpPeriodic", "UpdateSAngle(T)", UpdateShooterMotor)

function ShooterAngleEnable()
	AnglePID:Enable()
end
hook.add("RobotInit", "EnableSAng", ShooterAngleEnable)

function ShooterAngleDisable()
	AnglePID:Reset()
end
hook.add("DisabledInit", "DisableSAng", ShooterAngleDisable)


local L_ = {
	P = 0.0,
	I = 0.0,
	D = 0.0
	}

local R_ = {
	P = 0.0,
	I = 0.0,
	D = 0.0
	}

local REVERSE_LEFT = false
local REVERSE_RIGHT = false

local FULL_WHEEL_SPEED = 1

local LJag = wpilib.Jaguar(JAG_LEFT)
local RJag = wpilib.Jaguar(JAG_RIGHT)

local LEnc = wpilib.Encoder(ENC_LEFT_A, ENC_LEFT_B)
local REnc = wpilib.Encoder(ENC_RIGHT_A, ENC_RIGHT_B)

local LPidC = wpilib.PIDController(L_.P, L_.I, L_.D, LEnc, LJag)
local LPidC = wpilib.PIDController(R_.P, R_.I, R_.D, REnc, RJag)


function DriveWithController()
	local x = GetJoyAxis(1, 1)
	local y = GetJoyAxis(1, 2)
	local left = y + x
	local right = y - x
	
	if (left > 1) then
		left = 1
	else if (left < -1) then
		left = -1
	end
	
	if (right > 1) then
		right = 1
	else if (right < -1) then
		right = -1
	end
	
	if (REVERSE_LEFT) then
		left = -left
	end
	if (REVERSE_RIGHT) then
		right = -right
	end
	left *= FULL_WHEEL_SPEED
	right *= FULL_WHEEL_SPEED
	LPidC:SetSetpoint(left)
	RPidC:SetSetpoint(right)
	
end
hook.add("TeleOpPeriodic","DriveWithController",DriveWithController)

function EnableMotors()
	LPidC:Enable()
	RPidC:Enable()
end
hook.add("TeleOpInit","EnableDriveMotors",EnableMotors)

function DisableMotors()
	LPidC:Reset()
	RPidC:Reset()
	--Reset disables
	--LPidC:Disable()
	--RPidC:Disable()
end
hook.add("DisabledInit","DisableDriveMotors",DisableMotors)

function SetLPID(p, i, d)
	LPidC:SetPID(p,i,d)
end

function SetRPID(p, i, d)
	RPidC:SetPID(p,i,d)
end


--Shooter.lua
SOL_FIRINGPIN 	= nil
VIC_SHOOTER 	= nil

--ShooterAngle.lua
POT_SHOOTERANGLE 	= nil

VIC_ANGLEMOTOR 		= nil

--Conveyor.lua
DIO_PROX1 	= nil
DIO_PROX2 	= nil
DIO_PROX3 	= nil
DIO_PROX4 	= nil

SOL_BREACH1		= nil
SOL_BREACH2 	= nil
SOL_CONVEYORPIN = nil
REL_SWEEPER 	= nil
REL_CONVEYOR 	= nil

--Climber.lua
SOL_C1REACH 	= nil
SOL_C1GRAB 		= nil
SOL_C2REACH 	= nil
REL_C2PULL 		= nil

--Drivetrain.lua
ENC_LEFT_A 		= nil
ENC_LEFT_B 		= nil
ENC_RIGHT_A 	= nil
ENC_RIGHT_B 	= nil

JAG_LEFT 	= nil
JAG_RIGHT 	= nil

--Compressor.lua
REL_COMP 		= nil
PRESSURE_SWITCH = nil


--[[
-------						--------
-- SENSORS					-- ACTUATORS
-------						--------
Shooter.lua
							Sol Pin
							Vic Motor
ShooterAngle.lua
	Pot1					Vic Motor

Conveyor.lua
	Prox1					Sol(2) Breach
	Prox2					Sol Pin
	Prox3					Relay Sweeper
	Prox4					Relay Conveyor

Climber.lua
							Sol C1Reach
							Sol C1Grab
							Sol C2Reach
							Relay C2Pull
Drivetrain.lua
	Enc1					Jag Left
	Enc2					Jag Right

Compressor.lua
	Rel Comp				Pressure switch

------
-- GENERIC
------

Shooter.lua
	Firing pin
	Shooter

ShooterAngle.lua
	Shooter Angle

Conveyor.lua
	Breach
	Conveyor
	Conveyor Pin
	Sweeper
		Prox1
		Prox2
		Prox3
		Prox4

Climber.lua
	Climber1 Popup
	Climber1 Release
	Climber2 Popup
	Climber2 Pull Motor

Drivetrain.lua
	Drivetrain

	]]

local joyobjs = {}

local joys = {}
local joys[1] = {}
local joys[2] = {}
local joys_prev = {}
function InitJoysticks()
	joyobjs[1] = wpilib.Joystick(1)
	joyobjs[2] = wpilib.Joystick(2)
	
	--Initialize all joy buttons to off
	for k,v in pairs(joys) do
		for i=1,12 do
			v[i] = false
		end
	end

end
hook.Add("RobotInit", "InitJoysticks", InitJoysticks)

function CheckJoyButtons()
	joys_prev = joys
	for b = 1,12 do
		joy1b[b] = joy1:GetRawButton(b);
	end
	for jn,joy in ipairs(joys) do
		for b,v in ipairs(joy) do
			if (joys_prev[jn][b] ~= v) then
				hook.broadcast("JoyPress"..jn.."_"..b)
			end
		end
	end
end
hook.Add("TeleOpPeriodic", "CheckJoyButtons", CheckJoyButtons)

function GetJoyButton(jn, bn)
	return joys[jn][bn]
end

function GetJoyAxis(jn,an)
	return joyobjs[jn]:GetRawAxis(an)
end
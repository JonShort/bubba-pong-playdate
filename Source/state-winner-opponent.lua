import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

local function init()
end

local function update()
	gfx.drawTextAligned(string.format("You lose!"), 200, 100, kTextAlignment.center)

	gfx.drawTextAligned(string.format("Press A to return to title screen"), 200, 140, kTextAlignment.center)

	if (playdate.buttonJustPressed( playdate.kButtonA )) then
		SendGamestateAction("RESTART")
	end
end

local function cleanup()
end

WinnerOpponentMethods = {
	init=init,
	update=update,
	cleanup=cleanup
}

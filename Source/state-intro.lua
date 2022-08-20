import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

function introStateUpdater()
	gfx.drawTextAligned(string.format("Press A to play"), 200, 120, kTextAlignment.center)

	if (playdate.buttonJustPressed( playdate.kButtonA )) then
		updateState("START_GAME")
	end
end

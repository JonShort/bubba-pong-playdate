import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

function winnerPlayerInit()
end

function winnerPlayerStateUpdater()
	gfx.drawTextAligned(string.format("You win!"), 200, 100, kTextAlignment.center)

	gfx.drawTextAligned(string.format("Press A to return to title screen"), 200, 140, kTextAlignment.center)

	if (playdate.buttonJustPressed( playdate.kButtonA )) then
		updateState("RESTART")
	end
end

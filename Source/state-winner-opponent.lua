import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

function winnerOpponentStateUpdater()
	gfx.drawTextAligned(string.format("You lose! Press A to play again"), 200, 120, kTextAlignment.center)

	if (playdate.buttonJustPressed( playdate.kButtonA )) then
		updateState("RESTART")
	end
end

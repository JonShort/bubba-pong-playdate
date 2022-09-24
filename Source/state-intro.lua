import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

local function init()
end

local function update()
	gfx.drawTextAligned(string.format("Press A to play"), 200, 120, kTextAlignment.center)

	if (playdate.buttonJustPressed( playdate.kButtonA )) then
		sendGamestateAction("START_GAME")
	end
end

local function cleanup()
end

IntroMethods = {
	init=init,
	update=update,
	cleanup=cleanup
}

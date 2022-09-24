import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

gfx.setBackgroundColor(gfx.kColorWhite)
gfx.clear()

function playdate:update()
	StateUpdate()
end

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "border"
import "ball"
import "player"
import "opponent"

local gfx <const> = playdate.graphics

gfx.setBackgroundColor(gfx.kColorWhite)
gfx.clear()

local playerSprite = nil
local opponentSprite = nil
local ball = nil
local borders = nil

function gameSetup()
	player = createPlayer()
	opponent = createOpponent()
	ball = createBall()
	borders = borderSetup()
end

gameSetup()

function playdate.update()
	gfx.sprite.update()
	playdate.timer.updateTimers()
end

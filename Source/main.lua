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

-- sprites
local player <const> = createPlayer()
local opponent <const> = createOpponent()
local ball <const> = createBall()
local borders <const> = borderSetup()

function ball:update()
	-- To prevent restart - remove eventually
	if (playdate.buttonJustPressed(playdate.kButtonA)) then
		ball:reset()
		return
	end

	local next_x = self.x + ball.velocity_x
	local next_y = self.y + ball.velocity_y

	local actual_x, actual_y, collisions_list, number_of_collisions = self:moveWithCollisions(next_x, next_y)

	if (number_of_collisions < 1) then
		return
	end

	local collision_target = collisions_list[1].other

	if (collision_target:isa(borders["left"]) or collision_target:isa(borders["right"])) then
		ball.velocity_x = -ball.velocity_x
	end

	if (collision_target:isa(player) or collision_target:isa(opponent)) then
		if (ball.velocity_y >= 0) then
			ball.velocity_y = -(ball.velocity_y + 1)
		else
			ball.velocity_y = -(ball.velocity_y - 1)
		end
	end
end

function playdate.update()
	gfx.sprite.update()
	playdate.timer.updateTimers()
end

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

local player_score = 0
local opponent_score = 0

function ball:update()
	local next_x = self.x + ball.velocity_x
	local next_y = self.y + ball.velocity_y

	local actual_x, actual_y, collisions_list, number_of_collisions = self:moveWithCollisions(next_x, next_y)

	if (number_of_collisions < 1) then
		-- ball goes above top of screen
		if (next_y <= 0) then
			player_score += 1
			ball:reset()
		end

		-- ball goes below bottom of screen
		if (next_y >= 240) then
			opponent_score += 1
			ball:reset()
		end

		return
	end

	local collision_target = collisions_list[1].other

	if (collision_target:isa(borders["left"]) or collision_target:isa(borders["right"])) then
		ball.velocity_x = -ball.velocity_x
		return
	end

	local ball_x, _ = ball:getPosition()
	local target_x, _ = collision_target:getPosition()
	local target_size, _ = collision_target:getSize()

	local half_segment = target_size / 6
	local is_right_hit = ball_x >= target_x + half_segment;
	local is_left_hit = ball_x <= target_x - half_segment;

	if (collision_target:isa(player) or collision_target:isa(opponent)) then
		ball.velocity_y = ball.velocity_y >= 0 and -(ball.velocity_y + 1) or -(ball.velocity_y - 1)

		if (is_right_hit) then
			ball.velocity_x += 2
		end

		if (is_left_hit) then
			ball.velocity_x -= 2
		end
	end
end

function playdate.update()
	gfx.sprite.update()
	gfx.drawText(string.format("%i:%i", player_score, opponent_score), 15, 110)
	playdate.timer.updateTimers()
end

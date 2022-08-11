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
local player = createPlayer()
local opponent = createOpponent()
local ball = createBall()
local borders = borderSetup()

local velocity_x = 3
local velocity_y = 1
local max_velocity = 8

function ball:update()
	local next_x = self.x + velocity_x
	local next_y = self.y + velocity_y

	local actual_x, actual_y, collisions_list, number_of_collisions = self:moveWithCollisions(next_x, next_y)

	if (number_of_collisions < 1) then
		return
	end

	local collision_target = collisions_list[1].other
	
	if (collision_target:isa(borders["left"]) or collision_target:isa(borders["right"])) then
		velocity_x = -velocity_x
	end
end

function playdate.update()
	gfx.sprite.update()
	playdate.timer.updateTimers()
end

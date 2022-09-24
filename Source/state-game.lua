import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "border"
import "ball"
import "player"
import "opponent"
import "stateMachine"

local gfx <const> = playdate.graphics
local snd <const> = playdate.sound

-- sounds
local synth = snd.synth.new(snd.kWaveSawtooth)
synth:setADSR(0, 0.1, 0, 0)

-- sprites
local player <const> = CreatePlayer()
local opponent <const> = CreateOpponent()
local ball <const> = CreateBall()
local borders <const> = BorderSetup()

-- scores
local player_score = 0
local opponent_score = 0
local target_score = 5
local winner = ""

local function init()
	player_score = 0
	opponent_score = 0
	winner = ""

	-- setup sprites
	player:add()
	opponent:add()
	ball:add()
	borders["left"]:add()
	borders["right"]:add()
end

function ball:update()
	local next_x = self.x + ball.velocity_x
	local next_y = self.y + ball.velocity_y

	if (next_y < 190 and self.x < opponent.x - 5) then
		opponent:moveLeft()
	elseif (next_y < 190 and self.x > opponent.x + 5) then
		opponent:moveRight()
	end

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
		synth:playNote(100)
		return
	end

	local ball_x, _ = ball:getPosition()
	local target_x, _ = collision_target:getPosition()
	local target_size, _ = collision_target:getSize()

	local half_segment = target_size / 6
	local is_right_hit = ball_x >= target_x + half_segment;
	local is_left_hit = ball_x <= target_x - half_segment;

	local is_player_hit = collision_target:isa(player)
	local is_opponent_hit = collision_target:isa(opponent)

	if (is_opponent_hit) then
		ball.velocity_y = -(ball.velocity_y - 1)

		if (is_right_hit) then
			ball.velocity_x += 2
		end

		if (is_left_hit) then
			ball.velocity_x -= 2
		end

		synth:playNote(150)
	end

	if (is_player_hit) then
		ball.velocity_y = -(ball.velocity_y + 1)

		local movement_delta = 0

		if (is_right_hit) then
			movement_delta += 2
		end

		if (is_left_hit) then
			movement_delta -= 2
		end

		if (playdate.buttonIsPressed( playdate.kButtonLeft )) then
			movement_delta -= 2
		end

		if playdate.buttonIsPressed( playdate.kButtonRight ) then
			movement_delta += 2
		end

		ball.velocity_x += movement_delta

		opponent.rollForBoostChance()
		synth:playNote(200)
	end
end

local function update()
	if (player_score >= target_score) then
		SendGamestateAction("PLAYER_WINS")
		return
	end

	if (opponent_score >= target_score) then
		SendGamestateAction("OPPONENT_WINS")
		return
	end

	gfx.sprite.update()
	playdate.timer.updateTimers()
	gfx.drawText(string.format("%i:%i", player_score, opponent_score), 15, 110)
end

local function cleanup()
	player_score = 0
	opponent_score = 0
	winner = ""

	gfx.sprite.removeSprite(player)
	gfx.sprite.removeSprite(opponent)
	gfx.sprite.removeSprite(ball)
	gfx.sprite.removeSprite(borders["left"])
	gfx.sprite.removeSprite(borders["right"])
end

GameMethods = {
	init=init,
	update=update,
	cleanup=cleanup
}

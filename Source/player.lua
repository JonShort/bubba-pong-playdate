local gfx <const> = playdate.graphics

local player_width <const> = 60
local player_height <const> = 10

local function drawPlayer()
	gfx.setLineWidth(1)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(0, 0, player_width, player_height)
end

local function updatePlayer(self)
	local left_pressed = playdate.buttonIsPressed( playdate.kButtonLeft )
	local right_pressed = playdate.buttonIsPressed( playdate.kButtonRight )

	if (left_pressed or right_pressed) then
		local move_amount = right_pressed and 5 or -5

		if playdate.buttonIsPressed( playdate.kButtonB ) then
			move_amount *= 2
		end

		local goal_x = self.x + move_amount

		local actual_x, actual_y, collisions_list, number_of_collisions = self:moveWithCollisions(goal_x, self.y)

		if (number_of_collisions > 0) then
			return
		end
	end
end

function createPlayer()
	local player = gfx.sprite.new()
	player.draw = drawPlayer
	player.update = updatePlayer
	player:setSize(player_width, player_height)
	player:moveTo(200, 234)
	player:setCollideRect(0, 0, player_width, 1)
	player:add()

	return player
end

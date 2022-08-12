local gfx <const> = playdate.graphics

local opponent_width <const> = 60
local opponent_height <const> = 10

local function drawOpponent()
	gfx.setLineWidth(1)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(0, 0, opponent_width, opponent_height)
end

local function updateOpponent(self)
	local left_pressed = playdate.buttonIsPressed( playdate.kButtonLeft )
	local right_pressed = playdate.buttonIsPressed( playdate.kButtonRight )

	if (left_pressed or right_pressed) then
		local move_amount = right_pressed and 3 or -3

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

function createOpponent()
	local opponent = gfx.sprite.new()
	opponent.draw = drawOpponent
	opponent.update = updateOpponent
	opponent:setSize(opponent_width, opponent_height)
	opponent:setCollideRect(0, opponent_height - 1, opponent_width, 1)
	opponent:moveTo(200, 7)
	opponent:add()

	return opponent
end

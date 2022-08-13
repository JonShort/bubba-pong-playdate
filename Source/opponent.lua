local gfx <const> = playdate.graphics

local opponent_width <const> = 60
local opponent_height <const> = 10
local boost_chance <const> = 50
local is_boosting = false

local function drawOpponent()
	gfx.setLineWidth(1)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(0, 0, opponent_width, opponent_height)
end

local function rollForBoostChance()
	is_boosting = math.random(100) >= boost_chance
end

local function move(self, x_amount)
	local move_amount = is_boosting and x_amount * 2 or x_amount
	self:moveWithCollisions(self.x + move_amount, self.y)
end

function createOpponent()
	local opponent = gfx.sprite.new()
	opponent.draw = drawOpponent
	opponent.move = move
	opponent.rollForBoostChance = rollForBoostChance
	opponent:setSize(opponent_width, opponent_height)
	opponent:setCollideRect(0, opponent_height - 1, opponent_width, 1)
	opponent:moveTo(200, 7)
	opponent:add()

	return opponent
end

local gfx <const> = playdate.graphics

local base_speed <const> = 5
local boost_chance <const> = 50
local is_boosting = false

local function rollForBoostChance()
	is_boosting = math.random(100) >= boost_chance
end

local function moveRight(self)
	local move_amount = is_boosting and base_speed * 2 or base_speed
	self:moveWithCollisions(self.x + move_amount, self.y)
end

local function moveLeft(self, direction)
	local move_amount = is_boosting and -base_speed * 2 or -base_speed
	self:moveWithCollisions(self.x + move_amount, self.y)
end

function CreateOpponent()
	local playerImage = gfx.image.new("Images/bubba")
	assert(playerImage)

	local opponent = gfx.sprite.new(playerImage)

	local sprite_width, sprite_height = opponent:getSize()

	opponent.moveRight = moveRight
	opponent.moveLeft = moveLeft
	opponent.rollForBoostChance = rollForBoostChance
	opponent:setCollideRect(0, sprite_height - 1, sprite_width, 1)
	opponent:moveTo(200, 10)

	return opponent
end

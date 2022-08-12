local gfx <const> = playdate.graphics

local opponent_width <const> = 60
local opponent_height <const> = 10

local function drawOpponent()
	gfx.setLineWidth(1)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(0, 0, opponent_width, opponent_height)
end

local function updateOpponent(self)
	local move_amount = 2

	if playdate.buttonIsPressed( playdate.kButtonB ) then
		move_amount = 4
	end

	if playdate.buttonIsPressed( playdate.kButtonRight ) then
		self:moveBy( move_amount, 0 )
	end
	if playdate.buttonIsPressed( playdate.kButtonLeft ) then
		self:moveBy( -move_amount, 0 )
	end
end

function createOpponent()
	local opponent = gfx.sprite.new()
	opponent.draw = drawOpponent
	opponent.update = updateOpponent
	opponent:setSize(opponent_width, opponent_height)
	opponent:setCollideRect(0, 0, opponent:getSize())
	opponent:moveTo(200, 7)
	opponent:add()

	return opponent
end

local gfx <const> = playdate.graphics

local player_width <const> = 60
local player_height <const> = 10

local function drawPlayer()
	gfx.setLineWidth(1)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(0, 0, player_width, player_height)
end

local function updatePlayer(self)
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

function createPlayer()
	local player = gfx.sprite.new()
	player.draw = drawPlayer
	player.update = updatePlayer
	player:setSize(player_width, player_height)
	player:moveTo(200, 234)
	player:setCollideRect(0, 0, player:getSize())
	player:add()

	return player
end

local gfx <const> = playdate.graphics

local player_width <const> = 60
local player_height <const> = 10

local function drawPlayer()
	gfx.setLineWidth(4)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(0, 0, player_width, player_height)
end

local function collisonResponse()
	return "bounce"
end

function createPlayer()
	local player = gfx.sprite.new()
	player.draw = drawPlayer
	player.collisonResponse = collisonResponse
	player:setSize(player_width, player_height)
	player:moveTo(200, 234)
	player:add()
	
	return player
end

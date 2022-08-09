local gfx <const> = playdate.graphics

function createPlayer()
	local playerImage = gfx.image.new("Images/player")
	assert(playerImage)
	
	local player = gfx.sprite.new(playerImage)
	player:moveTo(200, 230)
	player:add()
	
	return player
end

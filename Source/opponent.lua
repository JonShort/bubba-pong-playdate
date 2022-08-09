local gfx <const> = playdate.graphics

function createOpponent()
	local opponentImage = gfx.image.new("Images/opponent")
	assert(opponentImage)
	
	local opponent = gfx.sprite.new(opponentImage)
	opponent:moveTo(200, 17)
	opponent:add()
	
	return opponent
end

local gfx <const> = playdate.graphics

local ballRadius <const> = 7

local function drawBall()
	gfx.setColor(gfx.kColorBlack)
	gfx.setLineWidth(0)
	gfx.drawCircleAtPoint(ballRadius, ballRadius, ballRadius)
end

function createBall()
	local ball = gfx.sprite.new()
	ball.draw = drawBall
	ball:setSize(14, 14)
	ball:moveTo(200, 120)
	ball:setCollideRect(1, 1, 8, 8)
	ball:add()
	
	return ball
end

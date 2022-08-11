local gfx <const> = playdate.graphics

local ballRadius <const> = 5

local function drawBall()
	gfx.setColor(gfx.kColorBlack)
	gfx.setLineWidth(0)
	gfx.drawCircleAtPoint(ballRadius, ballRadius, ballRadius)
end

local function collisonResponse()
	return "bounce"
end

function createBall()
	local ball = gfx.sprite.new()
	ball.draw = drawBall
	ball.collisonResponse = collisonResponse
	ball:setSize(10, 10)
	ball:moveTo(200, 120)
	ball:setCollideRect(1, 1, 8, 8)
	ball:add()
	
	return ball
end

local gfx <const> = playdate.graphics

local function drawBorder(self, xPos, yPos, width, height)
	gfx.setColor(gfx.kColorWhite)
	gfx.fillRect(xPos, yPos, width, height)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(xPos, yPos, width, height)
end

local function createBorder(xPos, yPos, width, height)
	local border = gfx.sprite.new()
	border.draw = drawBorder
	border:setSize(width, height)
	border:moveTo(xPos, yPos)
	border:setCenter(0, 0)
	border:setCollideRect(0, 0, width, height)

	return border
end

function borderSetup()
	local borderSize = 2
	local displayWidth = playdate.display.getWidth()
	local displayHeight = playdate.display.getHeight()

	local results = {}
	results["left"] = createBorder(0, 0, borderSize, displayHeight)
	results["right"] = createBorder(displayWidth-borderSize, 0, borderSize, displayHeight)

	return results
end

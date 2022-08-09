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
	border:addSprite()
	border:setCollideRect(0, 0, width, height)
	
	return border
end

function borderSetup()
	local borderSize = 2
	local displayWidth = playdate.display.getWidth()
	local displayHeight = playdate.display.getHeight()

	local results = {}
	results["top"] = createBorder(0, 0, displayWidth, borderSize)
	results["bottom"] = createBorder(0, displayHeight-borderSize, displayWidth, borderSize)
	results["left"] = createBorder(0, borderSize, borderSize, displayHeight-borderSize*2)
	results["right"] = createBorder(displayWidth-borderSize, borderSize, borderSize, displayHeight-borderSize*2)

	return results
end

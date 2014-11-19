settingsScene = director:createScene()

-- Background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Menu_Design_Potrait.png")
background.xAnchor = 0.5
background.yAnchor = 0.5
local bg_width, bg_height = background:getAtlas():getTextureSize()
background.xScale = director.displayWidth / bg_width
background.yScale = director.displayHeight / bg_height

local exitGameButton

-- Exit game event handler, called when the user taps the Exit Game button
function exitGame(event)
	-- Switch to main men  scene
	switchToScene("main")
end

-- Create Exit Game button
exitGameButton = director:createSprite(director.displayCenterX, director.displayCenterY - 100, "textures/button_bg.png")
exitGameButton.xAnchor = 1.0
exitGameButton.yAnchor = -0.2
exitGameButton.xScale = 1
exitGameButton.yScale = 1
exitGameButton:addEventListener("touch", exitGame)
-- Create Exit Game button text
local label = director:createLabel( {
	x = 0, y = 0, 
	w = atlas_w, h = atlas_h, 
	hAlignment="centre", vAlignment="middle", 
	text="Exit Game", 
	textXScale = 2, textYScale = 2, 
	})
exitGameButton:addChild(label)
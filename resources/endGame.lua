endScene = director:createScene()

-- Background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Menu_Design_Potrait.png")
background.xAnchor = 0.5
background.yAnchor = 0.5
local bg_width, bg_height = background:getAtlas():getTextureSize()
background.xScale = director.displayWidth / bg_width
background.yScale = director.displayHeight / bg_height

local playButton

function mainMenu(event)
	-- Switch to game scene
	switchToScene("main")
end

-- Create Start Game button
playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/info_panel.png")
playButton.xAnchor = 1.0
playButton.yAnchor = -0.2
playButton.xScale = 1
playButton.yScale = 1
playButton:addEventListener("touch", mainMenu)
local label = director:createLabel( {
	x = 0, y = 0, 
	w = atlas_w, h = atlas_h, 
	hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
	text="Play again!"
})
playButton:addChild(label)
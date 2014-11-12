endScene = director:createScene()

local playButton

function mainMenu(event)
	-- Switch to game scene
	switchToScene("main")
end

-- Create Start Game button
playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/info_panel.png")
playButton.xAnchor = 0.5
playButton.yAnchor = 0.5
playButton.xScale = 0.5
playButton.yScale = 0.5
playButton:addEventListener("touch", mainMenu)
local label = director:createLabel( {
	x = 0, y = 0, 
	w = atlas_w, h = atlas_h, 
	hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
	text="Play again!"
})
playButton:addChild(label)
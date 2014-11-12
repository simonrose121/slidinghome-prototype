--[[
Pause Menu
--]]

-- Create a scene to contain the main menu
pauseScene = director:createScene()
-- UI
local continueGameButton
local exitGameButton

-- Continue game event handler, called when the user taps the Continue Game button
function continueGame(event)
	-- Switch to game scene
	switchToScene("game")
end

-- Exit game event handler, called when the user taps the Exit Game button
function exitGame(event)
	-- Switch to main men  scene
	switchToScene("main")
end

-- Create Continue Game button
continueGameButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "textures/button_bg.png")
local atlas = continueGameButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
continueGameButton.xAnchor = 0.5
continueGameButton.yAnchor = 0.5
continueGameButton.xScale = 0.5
continueGameButton.yScale = 0.5
continueGameButton:addEventListener("touch", continueGame)
-- Create Continue Game button text
local label = director:createLabel( {
	x = 0, y = 0, 
	w = atlas_w, h = atlas_h, 
	hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
	text="Continue"
})
continueGameButton:addChild(label)

-- Create Exit Game button
exitGameButton = director:createSprite(director.displayCenterX, director.displayCenterY - 100, "textures/button_bg.png")
exitGameButton.xAnchor = 0.5
exitGameButton.yAnchor = 0.5
exitGameButton.xScale = 0.5
exitGameButton.yScale = 0.5
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
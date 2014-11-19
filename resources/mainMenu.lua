--[[
Main Menu
--]]

-- Create a scene to contain the main menu
menuScene = director:createScene()
-- Background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Menu_Design_Potrait.png")
background.xAnchor = 0.5
background.yAnchor = 0.5
local bg_width, bg_height = background:getAtlas():getTextureSize()
background.xScale = director.displayWidth / bg_width
background.yScale = director.displayHeight / bg_height
-- UI
local playButton

-- New game event handler, called when the user taps the New Game button
function newGame(event)
	-- Switch to game scene
	switchToScene("game")
end

-- New game event handler, called when the user taps the New Game button
function helpMenu(event)
	-- Switch to game scene
	switchToScene("help")
end

-- New game event handler, called when the user taps the New Game button
function settingsMenu(event)
	-- Switch to game scene
	switchToScene("settings")
end

-- Create Start Game button
playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Start_Button.png")
playButton.xAnchor = 1.3
playButton.yAnchor = -1.8
playButton:addEventListener("touch", newGame)

-- Create Help Game button
playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Help_Button.png")
playButton.xAnchor = 2.1
playButton.yAnchor = -0.4
playButton:addEventListener("touch", helpMenu)

-- Create Settings Game button
playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Settings_Button.png")
playButton.xAnchor = 1.6
playButton.yAnchor = 1.6
playButton:addEventListener("touch", settingsMenu)
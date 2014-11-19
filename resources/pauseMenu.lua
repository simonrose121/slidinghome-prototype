--[[
Pause Menu
--]]

-- Create a scene to contain the main menu
pauseScene = director:createScene()

-- Background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Pause_Menu.png")
background.xAnchor = 0.5
background.yAnchor = 0.5
local bg_width, bg_height = background:getAtlas():getTextureSize()
background.xScale = director.displayWidth / bg_width
background.yScale = director.displayHeight / bg_height

-- UI
local continueGameButton
local settingsButton
local restartButton
local exitGameButton

-- Continue game event handler, called when the user taps the Continue Game button
function continueGame(event)
	-- Switch to game scene
	switchToScene("game")
end

-- Exit game event handler, called when the user taps the Exit Game button
function settings(event)
	-- Switch to main men  scene
	switchToScene("settings")
end



-- Exit game event handler, called when the user taps the Exit Game button
function exitGame(event)
	-- Switch to main men  scene
	switchToScene("main")
end

-- Create Continue Game button
continueGameButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "textures/Continue_Button.png")
continueGameButton.xAnchor = 0.5
continueGameButton.yAnchor = -0.5
continueGameButton.xScale = 1
continueGameButton.yScale = 1
continueGameButton:addEventListener("touch", continueGame)

-- Create settings button
settingsButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "textures/Settings_Button_2.png")
settingsButton.xAnchor = 0.5
settingsButton.yAnchor = 1.0
settingsButton.xScale = 1
settingsButton.yScale = 1
settingsButton:addEventListener("touch", settings)

-- Create Restart Game button
restartButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "textures/Restart_Button.png")
restartButton.xAnchor = 0.5
restartButton.yAnchor = 2.5
restartButton.xScale = 1
restartButton.yScale = 1

-- Create Exit Game button
exitGameButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "textures/Exit_Button.png")
exitGameButton.xAnchor = 0.5
exitGameButton.yAnchor = 4.0
exitGameButton.xScale = 1
exitGameButton.yScale = 1
exitGameButton:addEventListener("touch", exitGame)
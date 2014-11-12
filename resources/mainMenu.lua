--[[
Main Menu
--]]

-- Create a scene to contain the main menu
menuScene = director:createScene()
-- UI
local playButton
local playText

-- New game event handler, called when the user taps the New Game button
function newGame(event)
	-- Switch to game scene
	switchToScene("game")
end

-- Create Start Game button
playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/info_panel.png")
playButton.xAnchor = 0.5
playButton.yAnchor = 0.5
playButton.xScale = 0.5
playButton.yScale = 0.5
playButton:addEventListener("touch", newGame)

-- Create Start Game button text
playText = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/play.png")
playText.xAnchor = 0.5
playText.yAnchor = 0.5
playText.xScale = 0.5
playText.yScale = 0.5

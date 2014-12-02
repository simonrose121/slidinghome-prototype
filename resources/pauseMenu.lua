--[[
Pause Menu
--]]

module(..., package.seeall)

-- Globals
pauseScene = nil

-- UI
local continueGameButton
local settingsButton
local restartButton
local exitGameButton

local playButton
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


function initUI()
	-- Create Continue Game button
	continueGameButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Continue_Button.png")
	continueGameButton.xAnchor = 0.5
	continueGameButton.yAnchor = -2
	continueGameButton.xScale = (director.displayWidth / 768) 
	continueGameButton.yScale = (director.displayWidth / 768) 
	continueGameButton:addEventListener("touch", continueGame)


	-- Create settings button
	settingsButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Settings_Button_2.png")
	settingsButton.xAnchor = 0.5
	settingsButton.yAnchor = -0.5
	settingsButton.xScale = (director.displayWidth / 768) 
	settingsButton.yScale = (director.displayWidth / 768) 
	settingsButton:addEventListener("touch", settings)

	-- Create Restart Game button
	restartButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Restart_Button.png")
	restartButton.xAnchor = 0.5
	restartButton.yAnchor = 1
	restartButton.xScale = (director.displayWidth / 768) 
	restartButton.yScale = (director.displayWidth / 768) 

	-- Create Exit Game button
	exitGameButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Exit_Button.png")
	exitGameButton.xAnchor = 0.5
	exitGameButton.yAnchor = 2.5
	exitGameButton.xScale = (director.displayWidth / 768) 
	exitGameButton.yScale = (director.displayWidth / 768) 
	exitGameButton:addEventListener("touch", exitGame)
end

function init()
	-- Create a scene to contain the main menu
	pauseScene = director:createScene()

	-- Background
	local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Pause_Menu.png")
	background.xAnchor = 0.5
	background.yAnchor = 0.5
	local bg_width, bg_height = background:getAtlas():getTextureSize()
	background.xScale = director.displayWidth / bg_width
	background.yScale = director.displayHeight / bg_height

	initUI()
end
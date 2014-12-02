--[[
Main Menu
--]]

module(..., package.seeall)

-- Globals
menuScene = nil

-- UI
local playButton

-- New game event handler, called when the user taps the New Game button
function levelSelect(event)
	-- Switch to game scene
	switchToScene("levelSelect")
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


function initUI()
	-- Create Start Game button
	playButton = director:createSprite(director.displayCenterX, (director.displayHeight/3), "textures/Start_Button.png")
	playButton.xAnchor = 1
	playButton.yAnchor = -4
	playButton.xScale = (director.displayWidth / 768) 
	playButton.yScale = (director.displayWidth / 768)
	playButton:addEventListener("touch", levelSelect)

	-- Create Help Game button
	playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Help_Button.png")
	playButton.xAnchor = 2.1
	playButton.yAnchor = -0.4
	playButton.xScale = (director.displayWidth / 768) 
	playButton.yScale = (director.displayWidth / 768)
	playButton:addEventListener("touch", helpMenu)

	-- Create Settings Game button
	playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Settings_Button.png")
	playButton.xAnchor = 1.6
	playButton.yAnchor = 1.6
	playButton.xScale = (director.displayWidth / 768) 
	playButton.yScale = (director.displayWidth / 768)
	playButton:addEventListener("touch", settingsMenu)

	--audio:playStream("audio/jinglebells.wav", true)
end

function init()
	-- Create a scene to contain the main menu
	menuScene = director:createScene()
	-- Background
	local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Menu_Design_Potrait.png")
	background.xAnchor = 0.5
	background.yAnchor = 0.5
	local bg_width, bg_height = background:getAtlas():getTextureSize()
	background.xScale = director.displayWidth / bg_width
	background.yScale = director.displayHeight / bg_height

	initUI()
end
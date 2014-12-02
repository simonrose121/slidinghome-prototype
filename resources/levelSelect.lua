--[[
Level Select
--]]

module(..., package.seeall)

-- Globals
levelScene = nil

local backButton
local bg_width
local bg_height

-- New game event handler, called when the user taps the New Game button
function newGame(event)
	-- Switch to game scene
	switchToScene("game")
end


function back(event)
	-- Switch to main menu scene
	switchToScene("main")
end


function initUI()
	-- Create Back button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Back_Button2.png")
	backButton.xAnchor = 4.75
	backButton.yAnchor = -5.75
	backButton.xScale = (director.displayWidth / 768) 
	backButton.yScale = (director.displayHeight / 768) 
	backButton:addEventListener("touch", back)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = 4.75
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="1", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = 3.5
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="2", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = 2.25
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="3", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = 1
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="4", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = -0.25
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="5", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = -1.5
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="6", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = -2.75
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="7", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)

	-- Create level button
	backButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	backButton.xAnchor = -4
	backButton.yAnchor = -4.5
	backButton.xScale = (director.displayWidth / bg_width ) 
	backButton.yScale = (director.displayHeight / bg_height ) 
	backButton:addEventListener("touch", newGame)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="8", 
		textXScale = 2, textYScale = 2, 
		})
	backButton:addChild(label)
end

function init()
	-- Create a scene to contain the main menu
	levelScene = director:createScene()

	-- Background
	local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Level_Menu.png")
	background.xAnchor = 0.5
	background.yAnchor = 0.5
	bg_width, bg_height = background:getAtlas():getTextureSize()
	background.xScale = director.displayWidth / bg_width
	background.yScale = director.displayHeight / bg_height

	initUI()
end
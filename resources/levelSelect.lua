--[[
Level Select
--]]

module(..., package.seeall)

-- Globals
levelScene = nil

local backButton
local bg_width
local bg_height

function level1(event)
	-- Switch to game scene
	_G.level = 1
	switchToScene("game")
end

function level2(event)
	-- Switch to game scene
	_G.level = 2
	switchToScene("game")
end

function level3(event)
	-- Switch to game scene
	_G.level = 3
	switchToScene("game")
end

function level4(event)
	-- Switch to game scene
	_G.level = 4
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
	level1Button = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	level1Button.xAnchor = 4.75
	level1Button.yAnchor = -4.5
	level1Button.xScale = (director.displayWidth / bg_width ) 
	level1Button.yScale = (director.displayHeight / bg_height ) 
	level1Button:addEventListener("touch", level1)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="1", 
		textXScale = 2, textYScale = 2, 
		})
	level1Button:addChild(label)

	local star1 = 0

	local file = io.open("star1.txt")
    if file ~= nil then
        star1 = tonumber(file:read())
    end

    if star1 > 0 then
        local starcomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
	starcomplete.xAnchor = 4.75
	starcomplete.yAnchor = -4.5
        starcomplete.xScale = (director.displayWidth / bg_width) 
        starcomplete.yScale = (director.displayHeight / bg_height) 
        levelcomplete = true
    end

	-- Create level button
	level2Button = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	level2Button.xAnchor = 3.5
	level2Button.yAnchor = -4.5
	level2Button.xScale = (director.displayWidth / bg_width ) 
	level2Button.yScale = (director.displayHeight / bg_height ) 
	level2Button:addEventListener("touch", level2)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="2", 
		textXScale = 2, textYScale = 2, 
		})
	level2Button:addChild(label)

	local star2 = 0

	local file = io.open("star2.txt")
    if file ~= nil then
        star2 = tonumber(file:read())
    end

    if star2 > 0 then
        local starcomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
		starcomplete.xAnchor = 3.5
		starcomplete.yAnchor = -4.5
        starcomplete.xScale = (director.displayWidth / bg_width) 
        starcomplete.yScale = (director.displayHeight / bg_height) 
        levelcomplete = true
    end

	-- Create level button
	level3Button = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	level3Button.xAnchor = 2.25
	level3Button.yAnchor = -4.5
	level3Button.xScale = (director.displayWidth / bg_width ) 
	level3Button.yScale = (director.displayHeight / bg_height ) 
	level3Button:addEventListener("touch", level3)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="3", 
		textXScale = 2, textYScale = 2, 
		})
	level3Button:addChild(label)

	local star3 = 0

	local file = io.open("star3.txt")
    if file ~= nil then
        star3 = tonumber(file:read())
    end

    if star3 > 0 then
        local starcomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
		starcomplete.xAnchor = 2.25
		starcomplete.yAnchor = -4.5
        starcomplete.xScale = (director.displayWidth / bg_width) 
        starcomplete.yScale = (director.displayHeight / bg_height) 
        levelcomplete = true
    end

	-- Create level button
	level4Button = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/level_button.png")
	level4Button.xAnchor = 1
	level4Button.yAnchor = -4.5
	level4Button.xScale = (director.displayWidth / bg_width ) 
	level4Button.yScale = (director.displayHeight / bg_height ) 
	level4Button:addEventListener("touch", level4)
	-- Create Number
	local label = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="4", 
		textXScale = 2, textYScale = 2, 
		})
	level4Button:addChild(label)

	local star4 = 0

	local file = io.open("star4.txt")
    if file ~= nil then
        star4 = tonumber(file:read())
    end

    if star4 > 0 then
        local starcomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
		starcomplete.xAnchor = 1
		starcomplete.yAnchor = -4.5
        starcomplete.xScale = (director.displayWidth / bg_width) 
        starcomplete.yScale = (director.displayHeight / bg_height) 
        levelcomplete = true
    end
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
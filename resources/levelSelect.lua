--[[
Level Select
--]]

-- Globals
levelScene = director:createScene()

local backButton
local bg_width
local bg_height
local background
local star1complete
local star2complete
local star3complete
local star4complete
local star1
local star2
local star3
local star4
local label1
local label2
local label3
local label4

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
	label1 = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="1", 
		textXScale = 2, textYScale = 2, 
		})
	level1Button:addChild(label1)

	local file = io.open("star1.txt")
    if file ~= nil then
        star1 = tonumber(file:read())
    end
    file:close()

    if star1 > 0 then
        star1complete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
		star1complete.xAnchor = 4.75
		star1complete.yAnchor = -4.5
        star1complete.xScale = (director.displayWidth / bg_width) 
        star1complete.yScale = (director.displayHeight / bg_height) 
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
	label2 = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="2", 
		textXScale = 2, textYScale = 2, 
		})
	level2Button:addChild(label2)

	local file = io.open("star2.txt")
    if file ~= nil then
        star2 = tonumber(file:read())
    end
    file:close()

    if star2 > 0 then
        star2complete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
		star2complete.xAnchor = 3.5
		star2complete.yAnchor = -4.5
        star2complete.xScale = (director.displayWidth / bg_width) 
        star2complete.yScale = (director.displayHeight / bg_height) 
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
	label3 = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="3", 
		textXScale = 2, textYScale = 2, 
		})
	level3Button:addChild(label3)

	local file = io.open("star3.txt")
    if file ~= nil then
        star3 = tonumber(file:read())
    end
    file:close()

    if star3 > 0 then
        star3complete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
		star3complete.xAnchor = 2.25
		star3complete.yAnchor = -4.5
        star3complete.xScale = (director.displayWidth / bg_width) 
        star3complete.yScale = (director.displayHeight / bg_height) 
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
	label4 = director:createLabel( {
		x = 0, y = 0, 
		w = atlas_w, h = atlas_h, 
		hAlignment="centre", vAlignment="middle", 
		text="4", 
		textXScale = 2, textYScale = 2, 
		})
	level4Button:addChild(label4)

	local file = io.open("star4.txt")
    if file ~= nil then
        star4 = tonumber(file:read())
    end
    file:close()

    if star4 > 0 then
        star4complete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
		star4complete.xAnchor = 1
		star4complete.yAnchor = -4.5
        star4complete.xScale = (director.displayWidth / bg_width) 
        star4complete.yScale = (director.displayHeight / bg_height) 
        levelcomplete = true
    end
end

function init()
	-- Background
	background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Level_Menu.png")
	background.xAnchor = 0.5
	background.yAnchor = 0.5
	bg_width, bg_height = background:getAtlas():getTextureSize()
	background.xScale = director.displayWidth / bg_width
	background.yScale = director.displayHeight / bg_height


end

function levelScene:setUp(event)
	print("setting up level select")
	init()
	initUI()
end

function levelScene:tearDown(event)
	print("tearing down level select")
	background:removeFromParent()

	if(star1 ~= 0) then
		star1complete:removeFromParent()
		star1complete = nil
	end

	if(star2 ~= 0) then
		star2complete:removeFromParent()
		star2complete = nil
	end

	if(star3 ~= 0) then
		star3complete:removeFromParent()
		star3complete = nil
	end

	if(star4 ~= 0) then
		star4complete:removeFromParent()
		star4complete = nil
	end

	label1:removeFromParent()
	label1 = nil

	label2:removeFromParent()
	label2 = nil

	label3:removeFromParent()
	label3 = nil

	label4:removeFromParent()
	label4 = nil

	star1 = nil
	star2 = nil
	star3 = nil
	star4 = nil

	collectgarbage("collect")
    director:cleanupTextures()

    backButton:removeEventListener("touch", back)
    level1Button:removeEventListener("touch", level1)
    level2Button:removeEventListener("touch", level2)
    level3Button:removeEventListener("touch", level3)
    level4Button:removeEventListener("touch", level4)
end

levelScene:addEventListener({"setUp", "tearDown"}, levelScene)
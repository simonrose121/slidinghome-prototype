-- Create the game scene

module(..., package.seeall)

gameScene = nil

local class = require("class")
require("mainMenu")
require("pauseMenu")
require("levelSelect")
require("endGame")

local graphicDesignWidth = 768    
local graphicsScale = director.displayWidth / graphicDesignWidth
local bg_width
local bg_height 

local grid
local player
local cellsize = 64 * graphicsScale
local scale = 1
local swipeOffset = 200
local minimumSwipe = 100
local speed = 8
local playerTween
local startX
local startY
local tmpX
local tmpY
local direction
local index = 1
local animationDelay = 1/8
local star = 0
local map
local staruncomplete
local starcomplete
local levelcomplete = false

function load()
    local file = io.open("star.txt")
    if file ~= nil then
      star = tonumber(file:read())
    end
end

function save()
    local file = io.open("star.txt", "w")
    file:write(star.."\n")
    file:close()
end

function isLevelComplete()
    if star == 0 then
        staruncomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_uncomplete.png")
        staruncomplete.xAnchor = -4.5
        staruncomplete.yAnchor = -8
        staruncomplete.xScale = (director.displayWidth / bg_width) 
        staruncomplete.yScale = (director.displayHeight / bg_height) 
    elseif star > 0 then
        starcomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
        starcomplete.xAnchor = -4.5
        starcomplete.yAnchor = -8
        starcomplete.xScale = (director.displayWidth / bg_width) 
        starcomplete.yScale = (director.displayHeight / bg_height) 
        levelcomplete = true
    end
end

--level 1
local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 2, 0, 0, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
}
--[[
--level 2
local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1 },
      { 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
}

--level 3
local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1 },
      { 1, 2, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1 },
      { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
}

--level 4
local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1 },
      { 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1 },
      { 1, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
}

--level 5
local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 2, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
}
]]--

local rightAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/right.png" })
local leftAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/left.png" })
local downAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/down.png" })
local upAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/up.png" })

function createGrid()
    for y = 1, #map do
        for x = 1, #map[y] do
            if map[y][x] == 1 then
                rock = director:createSprite({
                    source="textures/rock.png",
                    x=y*cellsize,
                    y=x*cellsize,
                    xScale = graphicsScale, 
                    yScale = graphicsScale, 
                })
            end
            if map[y][x] == 2 then
                player = director:createSprite({
                    source="textures/character.png",
                    x=y*cellsize,
                    y=x*cellsize,
                    xScale = graphicsScale, 
                    yScale = graphicsScale, 
                })
            end
            if map[y][x] == 3 then
                igloo = director:createSprite({
                    source="textures/igloo.png",
                    x=y*cellsize,
                    y=x*cellsize,
                    xScale = graphicsScale, 
                    yScale = graphicsScale, 
                })
            end
            if map[y][x] == 4 then
                snowpatch = director:createSprite({
                    source="textures/snowpatch.png",
                    x=y*cellsize,
                    y=x*cellsize,
                    xScale = graphicsScale, 
                    yScale = graphicsScale, 
                })
            end
        end
    end
end

function initAudio()
    -- Preload sound effects
    --audio:stopStream("audio/jinglebells.wav")
    audio:loadSound("audio/slide.wav")
end

function testObstacle(xDir, yDir)
   -- Contract: 
   --           either xDir or yDir must be 0
   --           xDir and yDir can only be -1,0,1
    index = 1
    local playerX = math.floor((player.x / cellsize) + 0.5) --to round up if over .5
    local playerY = math.floor((player.y / cellsize) + 0.5)
    while (map[playerX + (xDir*index)][playerY + (yDir*index)] == 0) do
        index = (index + 1)
        map[playerX][playerY] = 0
    end
    tmpX = (playerX + (xDir * (index-1)))
    tmpY = (playerY + (yDir * (index-1)))
end

function testMap(xDir, yDir)
    local playerX = math.floor((player.x / cellsize) + 0.5)
    local playerY = math.floor((player.y / cellsize) + 0.5)
    if map[playerX + xDir][playerY + yDir] == 3 then
      if levelcomplete == false then
        star = star+1
        save()
      end
      --clean()
      switchToScene("end")
    end
end

function touch(event)
    if (event.phase == "began") then
      startX = event.x
      startY = event.y
    end
    if (event.phase == "moved") then
        if (playerTween == nil) then
            --left
            if (event.x < startX - minimumSwipe and event.y < startY + swipeOffset and event.y > startY-swipeOffset) then
                testObstacle(-1, 0)
                direction = "left"
                playerTween = tween:to(player, { x=tmpX*cellsize, time=index/speed, onStart=animatePlayer, onComplete=cancelTween, easing=ease.sineIn})
            --down
            elseif (event.y < startY - minimumSwipe and event.x < startX + swipeOffset and event.x > startX-swipeOffset) then
                testObstacle(0, -1)
                direction = "down"
                audio:playSound("audio/slide.wav") 
                playerTween = tween:to(player, { y=tmpY*cellsize, time=index/speed, onStart=animatePlayer, onComplete=cancelTween, easing=ease.sineIn })
            --right
            elseif (event.x > startX + minimumSwipe and event.y < startY + swipeOffset and event.y > startY-swipeOffset) then
                testObstacle(1, 0)
                direction = "right"
                audio:playSound("audio/slide.wav") 
                playerTween = tween:to(player, { x=tmpX*cellsize, time=index/speed, onStart=animatePlayer, onComplete=cancelTween, easing=ease.sineIn })
            --up
            elseif (event.y > startY + minimumSwipe and event.x < startX + swipeOffset and event.x > startX-swipeOffset) then
                testObstacle(0, 1)
                direction = "up"
                audio:playSound("audio/slide.wav") 
                playerTween = tween:to(player, { y=tmpY*cellsize, time=index/speed, onStart=animatePlayer, onComplete=cancelTween, easing=ease.sineIn })
            end
        end
    end
end

function animatePlayer()
    if(direction == "left") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=leftAn, delay=animationDelay} ))
    end
    if(direction == "down") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=downAn, delay=animationDelay} ))
    end
    if(direction == "right") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=rightAn, delay=animationDelay} ))
    end
    if(direction == "up") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=upAn, delay=animationDelay} ))
    end
end

function cancelTween()
    if(direction == "left") then
        player:pause()
        testMap(-1, 0)
    end
    if(direction == "down") then
        player:pause()
        testMap(0, -1)
    end
    if(direction == "right") then
        player:pause()
        testMap(1, 0)
    end
    if(direction == "up") then
        player:pause()
        testMap(0, 1)
    end
    tween:cancel(playerTween)
    playerTween = nil
end

function clean(event) 
    --reset map array
    map = {}
    --remove objects
    rock:removeFromParent()
    player:removeFromParent()
    igloo:removeFromParent()
    --snowpatch:removeFromParent()
    rock = nil
    player = nil
    igloo = nil
    snowpatch = nil

    collectgarbage("collect")
    director:cleanupTextures()
end

function pauseGame(event)
  if (event.phase == "ended") then
    -- Switch to the pause scene
        gameScene:pauseTweens()
        switchToScene("pause")
  end
end

function initUI()
  -- Create pause menu sprite (docked to top of screen)
  -- Background
  local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Background_1st_Level.png")
  background.xAnchor = 0.5
  background.yAnchor = 0.5
  bg_width, bg_height = background:getAtlas():getTextureSize()
  background.xScale = director.displayWidth / bg_width
  background.yScale = director.displayHeight / 850


  local pause_sprite = director:createSprite( {
      x = director.displayCenterX, y = 0, 
      xAnchor = 0.5,
      yAnchor = 0, 
      xScale = graphicsScale,
      yScale = graphicsScale,
      source = "textures/pause_icon.png"
  } )
  pause_sprite:addEventListener("touch", pauseGame)
end

function init()
    gameScene = director:createScene()
    
    initAudio()
    initUI()
    load()
    isLevelComplete()
    createGrid()

    endGame.init()
    levelSelect.init()
    pauseMenu.init()
    mainMenu.init()

    system:addEventListener("touch", touch)
end



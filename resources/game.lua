-- Create the game scene
gameScene = director:createScene()

local graphicDesignWidth = 768    
local graphicsScale = director.displayWidth / graphicDesignWidth

-- Background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Background_1st_Level.png")
background.xAnchor = 0.5
background.yAnchor = 0.5
local bg_width, bg_height = background:getAtlas():getTextureSize()
background.xScale = director.displayWidth / bg_width
background.yScale = director.displayHeight / 850

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

function levelComplete()
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
local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 1 },
      { 1, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
  }

local debug = director:createLabel( {
    x=0, y=director.displayHeight - 30,
    w=director.displayWidth, h = 30,
    hAlignment="left", vAlignment="top",
    text="",
    color=color.yellow
})

local rightAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/right.png" })
local leftAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/left.png" })
local downAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/down.png" })
local upAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/up.png" })

function createGrid()
    for y = 1, #map do
        for x = 1, #map[y] do
            if map[y][x] == 1 then
                director:createSprite({
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
    local playerX = math.floor(player.x / cellsize)
    local playerY = math.floor(player.y / cellsize)
    while (map[playerX + (xDir*index)][playerY + (yDir*index)] == 0) do
        index = (index + 1)
        map[playerX][playerY] = 0
    end
    tmpX = (playerX + (xDir * (index-1)))
    tmpY = (playerY + (yDir * (index-1)))
end

function testMap(xDir, yDir)
    local playerX = math.floor(player.x / cellsize)
    local playerY = math.floor(player.y / cellsize)
    if map[playerX + xDir][playerY + yDir] == 3 then
      if levelcomplete == false then
        star = star+1
        save()
        --reset()
      end
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
                audio:playSound("audio/slide.wav") 
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
    if(direction == "right") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=rightAn, delay=animationDelay} ))
    end
    if(direction == "left") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=leftAn, delay=animationDelay} ))
    end
    if(direction == "up") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=upAn, delay=animationDelay} ))
    end
    if(direction == "down") then
        player:setAnimation(director:createAnimation( { start=1, count=3, atlas=downAn, delay=animationDelay} ))
    end
end

function cancelTween()
    if(direction == "up") then
        player:pause()
        testMap(0, 1)
    end
    if(direction == "down") then
        player:pause()
        testMap(0, -1)
    end
    if(direction == "left") then
        player:pause()
        testMap(-1, 0)
    end
    if(direction == "right") then
        player:pause()
        testMap(1, 0)
    end
    tween:cancel(playerTween)
    playerTween = nil
end

initAudio()
createGrid()
load()
levelComplete()
system:addEventListener("touch", touch)

function pauseGame(event)
	if (event.phase == "ended") then
    -- Switch to the pause scene
      switchToScene("pause")
  end
end

-- Create pause menu sprite (docked to top of screen)
local pause_sprite = director:createSprite( {
  	x = director.displayCenterX, y = 0, 
  	xAnchor = 0.5,
    yAchor = 0.5, 
    xScale = graphicsScale,
    yScale = graphicsScale,
  	source = "textures/pause_icon.png"
} )
sprite_w, sprite_h = pause_sprite:getAtlas():getTextureSize()
pause_sprite.y = director.displayHeight - sprite_h
pause_sprite:addEventListener("touch", pauseGame)

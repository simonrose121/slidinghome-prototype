-- Create the game scene
gameScene = director:createScene()

local grid
local player
local cellsize = 64
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

local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
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
              })
          end
          if map[y][x] == 2 then
              player = director:createSprite({
                  source="textures/character.png",
                  x=y*cellsize,
                  y=x*cellsize,
                  xScale=scale,
                  yScale=scale,
              })
          end
          if map[y][x] == 3 then
              igloo = director:createSprite({
                  source="textures/igloo.png",
                  x=y*cellsize,
                  y=x*cellsize,
                  xScale=scale,
                  yScale=scale
              })
          end
      end
  end
end

function testObstacle(xDir, yDir)
   -- Contract: 
   --           either xDir or yDir must be 0
   --           xDir and yDir can only be -1,0,1
    index = 1
    local playerX = player.x / cellsize
    local playerY = player.y / cellsize
    while (map[playerX + (xDir*index)][playerY + (yDir*index)] == 0) do
        index = (index + 1)
        map[playerX][playerY] = 0
    end
    tmpX = (playerX + (xDir * (index-1)))
    tmpY = (playerY + (yDir * (index-1)))
end

function testMap(xDir, yDir)
    local playerX = player.x / cellsize
    local playerY = player.y / cellsize
    if map[playerX + xDir][playerY + yDir] == 3 then
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
                playerTween = tween:to(player, { x=tmpX*cellsize, time=index/speed, onStart=animateChap, onComplete=cancelTween, easing=ease.sineIn })
            --down
            elseif (event.y < startY - minimumSwipe and event.x < startX + swipeOffset and event.x > startX-swipeOffset) then
                testObstacle(0, -1)
                direction = "down"
                playerTween = tween:to(player, { y=tmpY*cellsize, time=index/speed, onStart=animateChap, onComplete=cancelTween, easing=ease.sineIn })
            --right
            elseif (event.x > startX + minimumSwipe and event.y < startY + swipeOffset and event.y > startY-swipeOffset) then
                testObstacle(1, 0)
                direction = "right"
                playerTween = tween:to(player, { x=tmpX*cellsize, time=index/speed, onStart=animateChap, onComplete=cancelTween, easing=ease.sineIn })
            --up
            elseif (event.y > startY + minimumSwipe and event.x < startX + swipeOffset and event.x > startX-swipeOffset) then
                print("hit")
                testObstacle(0, 1)
                direction = "up"
                playerTween = tween:to(player, { y=tmpY*cellsize, time=index/speed, onStart=animateChap, onComplete=cancelTween, easing=ease.sineIn })
            end
        end
    end
end

function animateChap()
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
        testMap(1, 0)
    end
    if(direction == "right") then
        player:pause()
        testMap(-1, 0)
    end
    tween:cancel(playerTween)
    playerTween = nil
end

createGrid()
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
  	source = "textures/pause_icon.png"
} )
sprite_w, sprite_h = pause_sprite:getAtlas():getTextureSize()
pause_sprite.y = director.displayHeight - sprite_h
pause_sprite:addEventListener("touch", pauseGame)
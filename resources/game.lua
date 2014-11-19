-- Create the game scene
gameScene = director:createScene()

local grid
local gem
local cellsize = 64
local scale = 1
local swipeOffset = 100
local speed = 8
local gemTween
local startX
local startY
local tmpX
local tmpY
local index = 1

local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
  }

local debug = director:createLabel( {
    x=0, y=director.displayHeight - 30,
    w=director.displayWidth, h = 30,
    hAlignment="left", vAlignment="top",
    text="",
    color=color.yellow
})

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
              gem = director:createSprite({
                  source="textures/character.png",
                  x=y*cellsize,
                  y=x*cellsize,
                  xScale=scale,
                  yScale=scale
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
    local playerX = gem.x / cellsize
    local playerY = gem.y / cellsize
    while(map[playerX + (xDir*index)][playerY + (yDir*index)] == 0) do
      index = (index + 1)
      map[playerX][playerY] = 0
    end
    tmpX = (playerX + (xDir * (index-1)))
    tmpY = (playerY + (yDir * (index-1)))
end

function testMap(xDir, yDir)
  print("hit")
    local playerX = gem.x / cellsize
    local playerY = gem.y / cellsize
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
        if (gemTween == nil) then
            if (event.x < startX and event.y < startY+swipeOffset and event.y > startY-swipeOffset) then
                testObstacle(-1, 0)
                gemTween = tween:to(gem, { x=tmpX*cellsize, time=index/speed, onComplete=cancelTween, easing=ease.sineIn })
            --up
            elseif (event.y < startY and event.x < startX+swipeOffset and event.x > startX-swipeOffset) then
                testObstacle(0, -1)
                gemTween = tween:to(gem, { y=tmpY*cellsize, time=index/speed, onComplete=cancelTween, easing=ease.sineIn })
            --right
            elseif (event.x > startX and event.y < startY+swipeOffset and event.y > startY-swipeOffset) then
                testObstacle(1, 0)
                gemTween = tween:to(gem, { x=tmpX*cellsize, time=index/speed, onComplete=cancelTween, easing=ease.sineIn })
            --down
            elseif (event.y > startY and event.x < startX+swipeOffset and event.x > startX-swipeOffset) then
                testObstacle(0, 1)
                gemTween = tween:to(gem, { y=tmpY*cellsize, time=index/speed, onComplete=cancelTween, easing=ease.sineIn })
            end
        end
    end
end

function cancelTween()
    testMap(-1, 0)
    testMap(0, -1)
    testMap(1, 0)
    testMap(0, 1)
    tween:cancel(gemTween)
    gemTween = nil
end

createGrid()
system:addEventListener("touch", touch)
system:addEventListener("pressed", key)

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
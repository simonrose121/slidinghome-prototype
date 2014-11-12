-- Create the game scene
gameScene = director:createScene()

local grid
local gem
local cellsize = 24
local scale = 1
local swipeOffset = 100
local gemTween
local startX
local startY

local debug = director:createLabel( {
    x=0, y=director.displayHeight - 30,
    w=director.displayWidth, h = 30,
    hAlignment="left", vAlignment="top",
    text="0",
    color=color.yellow
})

function createGrid()
  grid = {}
  for px = 1, 11 do
    grid[px] = {}
    for py = 0, 18 do
      grid[px][py] = director:createSprite({
        source="textures/gridbox.png",
        x=px*cellsize,
        y=py*cellsize,
        xScale=scale,
        yScale=scale
      })
    end
  end
end

function initGem() 
  gem = director:createSprite({
    source="textures/gem.png",
    x=cellsize*6,
    y=cellsize*9,
    xScale=scale,
    yScale=scale
  })
end

function touch(event)  
    if (event.phase == "began") then
      startX = event.x
      startY = event.y
    end
    if (event.phase == "moved") then
      debug.text = "startX = " .. startX .. "\nevent.x = " .. event.x .. "\nstartY = " .. startY .. "\nevent.y = " .. event.y 
      if (gemTween == nil) then
        --left
        if (event.x < startX and event.y < startY+swipeOffset and event.y > startY-swipeOffset) then
          gemTween = tween:to(gem, { x=gem.x-cellsize, time=0.02 })
        --end
        --up
        elseif (event.y < startY and event.x < startX+swipeOffset and event.x > startX-swipeOffset) then
          gemTween = tween:to(gem, { y=gem.y-cellsize, time=0.02 })
        --end
        --right
        elseif (event.x > startX and event.y < startY+swipeOffset and event.y > startY-swipeOffset) then
          gemTween = tween:to(gem, { x=gem.x+cellsize, time=0.02 })
        --end
        --down
        elseif (event.y > startY and event.x < startX+swipeOffset and event.x > startX-swipeOffset) then
          gemTween = tween:to(gem, { y=gem.y+cellsize, time=0.02 })
        end
      end
    end
    if (event.phase == "ended") then
      tween:cancel(gemTween)
      gemTween = nil
    end
end

createGrid()
initGem()
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
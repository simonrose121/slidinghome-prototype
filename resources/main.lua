local grid
local gem
local cellsize = 24
local scale = 1
local swipeOffset = 100
local gemTween
local startX
local startY

local map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
  }

local debug = director:createLabel( {
    x=0, y=director.displayHeight - 30,
    w=director.displayWidth, h = 30,
    hAlignment="left", vAlignment="top",
    color=color.yellow
})

function createGrid()
  for x = 1, #map do
      for y = 1, #map[x] do
          if map[x][y] == 1 then
              director:createSprite({
                  source="textures/gridbox.png",
                  x=y*cellsize,
                  y=x*cellsize,
              })
          end
          if map[x][y] == 2 then
              gem = director:createSprite({
                  source="textures/gem.png",
                  x=y*cellsize,
                  y=x*cellsize,
                  xScale=scale,
                  yScale=scale
              })
          end
      end
  end
end

function testMap(x ,y)
    local tempx = gem.y / cellsize + y
    local tempy = gem.x / cellsize + x
    debug.text = "x " .. tempx .. " y " .. tempy .. " map " .. map[tempx][tempy]
    if map[tempx][tempy] == 1 then
        return false
    end
    return true
end

function touch(event)  
    if (event.phase == "began") then
      startX = event.x
      startY = event.y
    end
    if (event.phase == "moved") then
      if (gemTween == nil) then
        if (event.x < startX and event.y < startY+swipeOffset and event.y > startY-swipeOffset) then
            if testMap(-1, 0) then
                gemTween = tween:to(gem, { x=gem.x-cellsize, time=0.02 })
            end
        --up
        elseif (event.y < startY and event.x < startX+swipeOffset and event.x > startX-swipeOffset) then
            if testMap(0, -1) then
                gemTween = tween:to(gem, { y=gem.y-cellsize, time=0.02 })
            end
        --right
        elseif (event.x > startX and event.y < startY+swipeOffset and event.y > startY-swipeOffset) then
            if testMap(1, 0) then
                gemTween = tween:to(gem, { x=gem.x+cellsize, time=0.02 })
            end
        --down
        elseif (event.y > startY and event.x < startX+swipeOffset and event.x > startX-swipeOffset) then
            if testMap(0, 1) then
                gemTween = tween:to(gem, { y=gem.y+cellsize, time=0.02 })
            end
        end
      end
    end
    if (event.phase == "ended") then
      tween:cancel(gemTween)
      gemTween = nil
    end
end

function cancelGemTween()
    tween:cancel(gemTween)
    gemTween = nil
end

createGrid()
system:addEventListener("touch", touch)
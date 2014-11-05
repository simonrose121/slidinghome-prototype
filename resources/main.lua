local grid
local gem
local cellsize = 48
local scale = 2
local gemTween
local startX
local startY

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
      if (gemTween == nil) then
        if (event.x > gem.x and event.x < startX) then
          gemTween = tween:to(gem, { x=gem.x-cellsize, time=0.02 })
        end
        if (event.y > gem.y and event.y < startY) then
          gemTween = tween:to(gem, { y=gem.y-cellsize, time=0.02 })
        end
        if (event.x < gem.x and event.x > startX) then
          gemTween = tween:to(gem, { x=gem.x+cellsize, time=0.02 })
        end
        if (event.y < gem.y and event.y > startY) then
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
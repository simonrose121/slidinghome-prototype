-- Create the game scene

gameScene = director:createScene()

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
local rocks = {}
local map = {}
local level_num
local background
local continueGameButton
local settingsButton
local restartButton
local exitGameButton
local pause_sprite

function load()
    local file = io.open("star" .. _G.level .. ".txt")
    if file ~= nil then
      star = tonumber(file:read())
    end
end

function save()
    local file = io.open("star" .. _G.level .. ".txt", "w")
    file:write(star.."\n")
    file:close()
end

-- Exit game event handler, called when the user taps the Exit Game button
function settings(event)
  -- Switch to main men  scene
  switchToScene("settings")
end

-- Exit game event handler, called when the user taps the Exit Game button
function exitGame(event)
  -- Switch to main men  scene
  switchToScene("levelSelect")
end

function isLevelComplete()
    staruncomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_uncomplete.png")
    staruncomplete.xAnchor = -4.5
    staruncomplete.yAnchor = -9
    staruncomplete.xScale = (director.displayWidth / bg_width) 
    staruncomplete.yScale = (director.displayHeight / bg_height) 
    if star > 0 then
        starcomplete = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/star_complete.png")
        starcomplete.xAnchor = -4.5
        starcomplete.yAnchor = -9
        starcomplete.xScale = (director.displayWidth / bg_width) 
        starcomplete.yScale = (director.displayHeight / bg_height) 
        levelcomplete = true
    end
end

function setMap(level) 
    if level == 1 or level == nil then
        map = {
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1 },
              { 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 3, 1 },
              { 1, 2, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 }
        }
    elseif level == 2 then
        map = {
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 4, 0, 0, 0, 0, 4, 0, 0, 4, 0, 0, 0, 0, 0, 1 },
              { 1, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 4, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 }
        }
    elseif level == 3 then
        map = {
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4, 0, 0, 0, 1 },
              { 1, 2, 0, 0, 0, 0, 4, 3, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 }
        }
    elseif level == 4 then
        map = {
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1 },
              { 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1 },
              { 1, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 4, 0, 0, 1 },
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 }
        }
    end
    --[[
    elseif level == 5 then
        map = {
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1 },
              { 1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1 },
              { 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1 }
        }
    end
    ]]--
end

local rightAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/right.png" })
local leftAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/left.png" })
local downAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/down.png" })
local upAn = director:createAtlas({ width=64, height=64, numFrames=3, textureName="textures/up.png" })

function createGrid()
    for y = 1, #map do
        for x = 1, #map[y] do
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
                rock = director:createSprite({
                    source="textures/rock.png",
                    x=y*cellsize,
                    y=x*cellsize,
                    xScale = graphicsScale, 
                    yScale = graphicsScale, 
                })
                table.insert(rocks, rock)
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
        switchToScene("levelSelect")
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
                playerTween = tween:to(player, { y=tmpY*cellsize, time=index/speed, onStart=animatePlayer, onComplete=cancelTween, easing=ease.sineIn })
            --right
            elseif (event.x > startX + minimumSwipe and event.y < startY + swipeOffset and event.y > startY-swipeOffset) then
                testObstacle(1, 0)
                direction = "right"
                playerTween = tween:to(player, { x=tmpX*cellsize, time=index/speed, onStart=animatePlayer, onComplete=cancelTween, easing=ease.sineIn })
            --up
            elseif (event.y > startY + minimumSwipe and event.x < startX + swipeOffset and event.x > startX-swipeOffset) then
                testObstacle(0, 1)
                direction = "up"
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

function pause(event)
    continueGameButton.alpha = 1
    settingsButton.alpha = 1
    exitGameButton.alpha = 1
    background.alpha = 0.2
    pause_sprite.alpha = 0
    player.alpha = 0
    igloo.alpha = 0
    for key,value in pairs(rocks) do
        rocks[key].alpha = 0
    end
    player:pauseTweens()
    player:pause()

    exitGameButton:addEventListener("touch", exitGame)
    settingsButton:addEventListener("touch", settings)
    continueGameButton:addEventListener("touch", continue)
end

function continue(event)
    continueGameButton.alpha = 0
    settingsButton.alpha = 0
    exitGameButton.alpha = 0
    pause_sprite.alpha = 1
    background.alpha = 1
    for key,value in pairs(rocks) do
        rocks[key].alpha = 1
    end
    player.alpha = 1
    igloo.alpha = 1
    player:resumeTweens()
    player:play()

    exitGameButton:removeEventListener("touch", exitGame)
    settingsButton:removeEventListener("touch", settings)
    continueGameButton:removeEventListener("touch", continue)
end


function initUI()
    background = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Background_1st_Level.png")
    background.xAnchor = 0.5
    background.yAnchor = 0.5
    bg_width, bg_height = background:getAtlas():getTextureSize()
    background.xScale = director.displayWidth / bg_width
    background.yScale = director.displayHeight / 850

    pause_sprite = director:createSprite( {
        x = director.displayCenterX, y = director.displayCenterY, 
        xAnchor = 6,
        yAnchor = -8,
        xScale = director.displayWidth / 768,
        yScale = director.displayWidth / 768,
        source = "textures/pause.png"
    } )

    continueGameButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Continue_Button.png")
    continueGameButton.xAnchor = 0.5
    continueGameButton.yAnchor = -2
    continueGameButton.xScale = (director.displayWidth / 768) 
    continueGameButton.yScale = (director.displayWidth / 768) 
    continueGameButton.alpha = 0

    settingsButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Settings_Button_2.png")
    settingsButton.xAnchor = 0.5
    settingsButton.yAnchor = 0.25
    settingsButton.xScale = (director.displayWidth / 768) 
    settingsButton.yScale = (director.displayWidth / 768) 
    settingsButton.alpha = 0

    exitGameButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/Exit_Button.png")
    exitGameButton.xAnchor = 0.5
    exitGameButton.yAnchor = 2.5
    exitGameButton.xScale = (director.displayWidth / 768) 
    exitGameButton.yScale = (director.displayWidth / 768) 
    exitGameButton.alpha = 0

    pause_sprite:addEventListener("touch", pause)
end

function gameScene:tearDown(event) 
    map = {}

    player:removeFromParent()
    igloo:removeFromParent()

    exitGameButton:removeFromParent()
    settingsButton:removeFromParent()
    continueGameButton:removeFromParent()

    staruncomplete:removeFromParent()
       
    if starcomplete ~= nil then
        starcomplete:removeFromParent()
    end

    startcomplete = nil
    staruncomplete = nil

    star = 0

    player = nil
    igloo = nil

    for key,value in pairs(rocks) do
        rocks[key]:removeFromParent()
        rocks[key] = nil
    end

    rocks = {}

    collectgarbage("collect")
    director:cleanupTextures()

    system:removeEventListener("touch", touch)
end

function gameScene:setUp(event)
    initAudio()
    initUI()
    load()
    isLevelComplete()
    setMap(_G.level)
    createGrid()

    system:addEventListener("touch", touch)
end

gameScene:addEventListener({"setUp", "tearDown"}, gameScene)

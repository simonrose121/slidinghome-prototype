local gem = director:createSprite({
    x=director.displayWidth / 2,
    y=director.displayHeight / 2,
    source="textures/gem.png",
})

local gemTween
  
function screenTouched(event)
    if (event.phase == "moved") then
        --swipe up to move gem down
        if (event.y > gem.y) then
            gemTween = tween:to(gem, { y=0, time=1, easing=ease.powIn, easingValue=3 })
        --swipe right to move left
        elseif (event.x < gem.x) then
            gemTween = tween:to(gem, { x=0, time=1, easing=ease.powIn, easingValue=3 })
        --swipe down to move gem up
        elseif (event.y < gem.y) then
            gemTween = tween:to(gem, { y=director.displayHeight-25, time=1, easing=ease.powIn, easingValue=3 })
        --swipe left to move gem right
        elseif (event.x > gem.x) then
            gemTween = tween:to(gem, { x=director.displayWidth-25, time=1, easing=ease.powIn, easingValue=3 })
        end
    end
end
  
system:addEventListener("touch", screenTouched)
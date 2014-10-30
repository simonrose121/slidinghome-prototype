local gem = director:createSprite({
    x=director.displayWidth / 2,
    y=director.displayHeight / 2,
    source="textures/gem.png",
    xAnchor=0.5,
    yAnchor=0.5
})

local gemTween
local currentScore = 0

-- Create a label to display the score
local scoreLabel = director:createLabel( {
    x=0, y=director.displayHeight - 30,
    w=director.displayWidth, h = 30,
    hAlignment="left", vAlignment="top",
    text="0",
    color=color.yellow
    })
  
-- Create an event handler function that is called when the user touches the gem
function gemTouched(event)
    if (event.phase == "ended") then
        -- Update the score
        currentScore = currentScore + 10
        scoreLabel.text = currentScore
        if (gemTween == nil) then
            -- Create a tween that scales the gem up and down
            gemTween = tween:to(gem, {
                xScale=2,
                time=1,
                mode="mirror"
                } )
        else
            -- Cancel the tween
            tween:cancel(gemTween)
            -- Destroy the tween
            gemTween = nil
            --Reset the gems xScale to 1.0
            gem.xScale = 1
        end
    end
end
  
-- Add the gemTouched event handler function to the sprites "touch" event listener
gem:addEventListener("touch", gemTouched)
endScene = director:createScene()

-- Create Start Game button
playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "textures/info_panel.png")
playButton.xAnchor = 0.5
playButton.yAnchor = 0.5
playButton.xScale = 0.5
playButton.yScale = 0.5
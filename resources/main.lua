require("mainMenu")
require("pauseMenu")
require("endGame")
require("game")
 
-- Switch to specific scene
function switchToScene(scene_name)
    if (scene_name == "game") then
        director:moveToScene(gameScene, {transitionType="slideInB", transitionTime=0.5})
    elseif (scene_name == "main") then
        director:moveToScene(menuScene, {transitionType="fade", transitionTime=0.5})
    elseif (scene_name == "pause") then
        director:moveToScene(pauseScene, {transitionType="slideInT", transitionTime=0.5})
    elseif (scene_name == "end") then
        director:moveToScene(endScene, {transitionType="fade", transitionTime=0.5})    
    end
end

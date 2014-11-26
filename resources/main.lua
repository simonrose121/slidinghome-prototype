require("mainMenu")
require("pauseMenu")
require("endGame")
require("game")
require("help")
require("settings")
require("levelSelect")

director:moveToScene(menuScene)

system:setFrameRateLimit(30)

-- Switch to specific scene
function switchToScene(scene_name)
    if (scene_name == "game") then
        director:moveToScene(gameScene, {transitionType="slideInR", transitionTime=0.5})
    elseif (scene_name == "main") then
        director:moveToScene(menuScene, {transitionType="fade", transitionTime=0.5})
    elseif (scene_name == "pause") then
        director:moveToScene(pauseScene, {transitionType="slideInL", transitionTime=0.5})
    elseif (scene_name == "end") then
        director:moveToScene(endScene, {transitionType="fade", transitionTime=0.5})    
    elseif (scene_name == "help") then
        director:moveToScene(helpScene, {transitionType="fade", transitionTime=0.5})  
    elseif (scene_name == "settings") then
        director:moveToScene(settingsScene, {transitionType="fade", transitionTime=0.5})  
    elseif (scene_name == "levelSelect") then
        director:moveToScene(levelScene, {transitionType="fade", transitionTime=0.5})  
    end
end

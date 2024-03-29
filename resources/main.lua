system:setFrameRateLimit(30)

require("mainMenu")
require("levelSelect")
require("endGame")
require("game")

endGame.init()
levelSelect.init()
mainMenu.init()

function switchToScene(scene_name)
    if (scene_name == "game") then
        director:moveToScene(gameScene, {transitionType="slideInR", transitionTime=0.5})
    elseif (scene_name == "main") then
        director:moveToScene(mainMenu.menuScene, {transitionType="fade", transitionTime=0.5})
    elseif (scene_name == "end") then
        director:moveToScene(endGame.endScene, {transitionType="fade", transitionTime=0.5})    
    elseif (scene_name == "help") then
        director:moveToScene(helpScene, {transitionType="fade", transitionTime=0.5})  
    elseif (scene_name == "settings") then
        director:moveToScene(settingsScene, {transitionType="fade", transitionTime=0.5})  
    elseif (scene_name == "levelSelect") then
        director:moveToScene(levelSelect.levelScene, {transitionType="fade", transitionTime=0.5})  
    end
end

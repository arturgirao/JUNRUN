local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local viewUtil = require(importations.VIEW_UTIL)
local aboutCreator = require(importations.ABOUT_CREATOR)
local adsManager = require(importations.ADS_MANAGER)

local scene = composer.newScene()

function scene:create()
    local sceneGroup = self.view

    local background = viewUtil.createBackground(images.ABOUT_BACKGROUND, 1800, 900)
    local backButton = viewUtil.createBackButton(background, sceneManager.goMenu)

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)

    aboutCreator.developedByGroup(sceneGroup)
    aboutCreator.designedByGroup(sceneGroup)
    aboutCreator.songsGroup(sceneGroup)
    aboutCreator.imagesGroup(sceneGroup)

    adsManager.show(adsManager.SUPPORTED_SCREENS.ABOUT)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:destroy()
    adsManager.hide()

    local sceneGroup = self.view

    sceneGroup:removeSelf()
    sceneGroup = nil

    -- Doing it because is needed but linter not known Corona SDK
    if (sceneGroup ~= nil) then
        print(sceneGroup)
    end
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene
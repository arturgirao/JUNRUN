local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local listener = require(importations.LISTENER)
local rules = require(importations.GAME_RULES)
local images = require(importations.IMAGES)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local viewUtil = require(importations.VIEW_UTIL)
local spritesManager = require(importations.SPRITES_MANAGER_RULES)

local scene = composer.newScene()
local defaultDisplayConfiguration = display.getDefault()

local sprite
local transitionTime = 2000
local transitionHandler

function scene:create()
    local sceneGroup = self.view

    display.setDefault('textureWrapX', 'mirroredRepeat')

    sprite = spritesManager.createCrazyScientist()

    local background = viewUtil.createBackground(images.MAIN_SCENE, 1472, 828)
    background.fill = { type = 'image', filename = images.MAIN_SCENE }

    local function infinitelyScrollingBackground()
        local fill = background.fill;

        transitionHandler = transition.to(fill, {
            time = transitionTime,
            x = 1,
            delta = true,
            onComplete = function()
                transition.cancel(transitionHandler)
                infinitelyScrollingBackground()
            end
        })
    end

    infinitelyScrollingBackground()

    local backButton = viewUtil.createBackButton(background, sceneManager.goMenu)

    local gameTitle = viewUtil.createImage({
        imagePath = images.TITLE,
        width = 261,
        height = 61,
        x = displayConstants.CENTER_X,
        y = displayConstants.TOP_SCREEN + 50
    })

    sprite:play()

    sceneGroup:insert(background)
    sceneGroup:insert(sprite)
    sceneGroup:insert(backButton)
    sceneGroup:insert(gameTitle)

    rules.apply(sceneGroup, background, sprite)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:destroy()
    rules.clear()

    local sceneGroup = self.view

    sceneGroup:removeSelf()
    sceneGroup = nil

    -- Doing it because is needed but linter not known Corona SDK
    if (sceneGroup ~= nil) then
        print(sceneGroup)
    end

    display.setDefault(defaultDisplayConfiguration)
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene
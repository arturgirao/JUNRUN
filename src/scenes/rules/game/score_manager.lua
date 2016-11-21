local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local viewUtil = require(importations.VIEW_UTIL)
local i18n = require(importations.I18N)
local bodyManager = require(importations.BODY_MANAGER)

local BEAR_SCORE = 50
local TIGER_SCORE = 100
local BIRD_SCORE = 150
local EAGLE_SCORE = BIRD_SCORE

local scoreText
local currentScore

local function _increase(score)
    currentScore = currentScore + score
    scoreText.text = i18n.score .. ': ' .. tostring(currentScore)
end

local function _setScore(score)
    currentScore = score
end

local function _increaseByAnimalName(animalName)
    local score = 0

    if (animalName == bodyManager.ANIMAL_NAME.BEAR) then

        score = BEAR_SCORE
    elseif (animalName == bodyManager.ANIMAL_NAME.TIGER) then

        score = TIGER_SCORE
    elseif (animalName == bodyManager.ANIMAL_NAME.BIRD) then

        score = BIRD_SCORE
    elseif (animalName == bodyManager.ANIMAL_NAME.EAGLE) then

        score = EAGLE_SCORE
    end

    _increase(score)
end

local function _start()
    currentScore = 0
    _increase(currentScore)
end

local function _createScoreView(group)
    scoreText = viewUtil.createText({
        text = i18n.score,
        x = displayConstants.LEFT_SCREEN + 2500,
        y = displayConstants.TOP_SCREEN + 500,
        fontSize = 35
    })

    group:insert(scoreText)
end

local function _currentScore()
    return currentScore
end

return {
    start = _start,
    createScoreView = _createScoreView,
    currentScore = _currentScore,
    increaseByAnimalName = _increaseByAnimalName,
	setScore = _setScore
}
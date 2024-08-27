-- state management
menu = require("states.menu")
options = require("states.options")
cards = require("mech.cards")
game = require("states.game")
currentState = menu

sfxState, bgmState = 'on', 'on'
sfxVol, bgmVol = 1, 1


function love.load()
    if bgmState then
        bgm = love.audio.newSource('assets/bgm/bgm.wav','stream')
    end
    bgm:setLooping(true)
    bgm:setVolume(bgmVol)
    love.audio.play(bgm)
    sfx = {
        scr=love.audio.newSource('assets/sfx/menuindex.wav','static'),
        sel=love.audio.newSource('assets/sfx/menuselect.wav','static')
    }
    sfx.scr:setVolume(sfxVol)
    sfx.sel:setVolume(sfxVol)
    currentState:load()
end

function love.update(dt)
    currentState:update(dt)
end

function love.draw()
    currentState:draw()
end

function love.keypressed(key)
    if currentState.keypressed then
        currentState:keypressed(key)
    end
end

-- function clearCallback()
--     love.load = nil
--     love.update = nil
--     love.draw = nil
--     love.keypressed = nil
--     love.mousepressed = nil
--     love.mousereleased = nil
--     love.textinput = nil
--     love.focus = nil
-- end

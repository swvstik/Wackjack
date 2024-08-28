-- state management
menu = require("states.menu")
options = require("states.options")
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
    collectgarbage("collect")
end

function love.draw()
    currentState:draw()
    love.graphics.setColor(0.4,0.4,0.4)
    love.graphics.print('X',750,30)
    love.graphics.setColor(1,1,1)
end

function love.keypressed(key)
    if currentState.keypressed then
        currentState:keypressed(key)
    end
end

function love.mousepressed(mouseX, mouseY, button, istouch, presses)
    if button == 1 then
        if mouseX >= 750 - 15 and mouseX <= 750 + 15 and mouseY >= 30 - 15 and mouseY <= 30 + 15 then
            love.event.quit()
        end
    end

    -- Call the current state's mousepressed function if it exists
    if currentState.mousepressed then
        currentState:mousepressed(mouseX, mouseY, button, istouch, presses)
    end
end

-- function clearCallback()
--     love.update = nil
--     love.draw = nil
--     love.keypressed = nil
--     love.mousepressed = nil
--     love.mousereleased = nil
--     love.textinput = nil
--     love.focus = nil
-- end

print(collectgarbage("count"))
collectgarbage("collect")

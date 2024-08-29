local options = {}

local li = {'sound effects: ', 'sfx volume: ', 'background music:', 'bgm volume: ', 'back to menu'}
local current = 1

function options:load()

end

function options:update(dt)

end

function options:draw()
    local w, h = love.graphics.getDimensions()
    love.graphics.setFont(love.graphics.newFont(20))
    local startY = (h - #li * 30) / 2

    for i, v in ipairs(li) do
        local text

        if i == 1 then
            text = v .. (sfxState == 'on' and ' on' or ' off')
        elseif i == 2 then
            text = v .. (sfxVol * 100)
        elseif i == 3 then
            text = v .. (bgmState == 'on' and ' on' or ' off')
        elseif i == 4 then
            text = v .. (bgmVol * 100)
        else
            text = v
        end

        -- Set color based on selection
        if i == current then
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("> " .. text, w / 2 - 150, startY + (i - 1) * 30)
        else
            love.graphics.setColor(0.75, 0.75, 0.75)
            love.graphics.print(text, w / 2 - 130, startY + (i - 1) * 30)
        end
    end
end

function options:keypressed(key)
    if key == 'down' or key == 'up' or key == 'left' or key == 'right' then
        love.audio.play(sfx.scr)
    end

    if key == 'down' then
        current = (current % #li) + 1
    elseif key == 'up' then
        current = (current - 2) % #li + 1
        if current <= 0 then
            current = #li
        end
    elseif key == 'left' then
        self:adjustOption(-1)
    elseif key == 'right' then
        self:adjustOption(1)
    elseif key == 'return' then
        if current == #li then
            love.graphics.clear()
            currentState = menu
            love.audio.play(sfx.sel)
            print("Returning to main menu...")
        end
    end
    if key == 'escape' then
        love.graphics.clear()
        currentState = menu
    end
end

function options:adjustOption(direction)
    if current == 1 then
        sfxState = (sfxState == 'on') and 'off' or 'on'
        self:updateSFXVolume()
    elseif current == 2 then
        sfxVol = math.max(0, math.min(1, sfxVol + (direction * 0.1)))
        self:updateSFXVolume()
    elseif current == 3 then
        bgmState = (bgmState == 'on') and 'off' or 'on'
        if bgmState == 'off' then
            bgm:stop()
        else
            bgm:setVolume(bgmVol)
            if not bgm:isPlaying() then
                love.audio.play(bgm)
            end
        end
    elseif current == 4 then
        bgmVol = math.max(0, math.min(1, bgmVol + (direction * 0.1)))
        if bgmState == 'on' then
            bgm:setVolume(bgmVol)
        end
    end
end


function options:updateSFXVolume()
    local sfmul = (sfxState == 'on') and 1 or 0
    sfxVol = sfmul * sfxVol
    for _, source in pairs(sfx) do
        source:setVolume(sfxVol)
    end
end

return options

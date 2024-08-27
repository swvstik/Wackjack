local menu={}

local li={'play','options','exit'}
local current=1

function menu:load()

end

function menu:update(dt)

end

function menu:draw()
    local gmnm = 'wackjack'
    local Hollirood = love.graphics.newFont('assets/fonts/Hollirood.ttf', 48)      
    love.graphics.setFont(Hollirood)
    love.graphics.printf(gmnm,  (love.graphics.getWidth() - Hollirood:getWidth(gmnm)) / 2, (love.graphics.getHeight() - Hollirood:getHeight(gmnm)) / 3,Hollirood:getWidth(gmnm), 'center')

    local w, h = love.graphics.getDimensions()
    love.graphics.setFont(love.graphics.newFont(20))

    for i,v in ipairs(li) do
        if i == current then
            love.graphics.setColor(1, 1, 1) -- White for selected current
            love.graphics.print("> " .. v, w / 2 - 50, (h - #li * 30) / 2 + (i - 1) * 30)
        else
            love.graphics.setColor(0.75, 0.75, 0.75) -- Light gray for non-selected options
            love.graphics.print(v, w / 2 - 30, (h - #li * 30) / 2 + (i - 1) * 30)
        end
    end
    print("Current index: " .. current)
    love.graphics.setColor(1, 1, 1)
end

function menu:keypressed(key)
    if key == 'down' or key=='up' then
        love.audio.play(sfx.scr)
    elseif key == 'return' then
        love.audio.play(sfx.sel)
    end
    if key=='down' then
        current = (current % #li) + 1
    elseif key=='up' then
        current = current - 1
        if current < 1 then
            current = #li
        end
    elseif key=='return' then
        if current==3 then
            love.event.quit()
        end
        if current==2 then
            love.graphics.clear()
            currentState=options
        end
        if current==1 then
            love.graphics.clear()
            currentState=game
        end
    end
end

return menu
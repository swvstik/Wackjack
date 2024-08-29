local menu={}

local li={'play','options','tutorial','exit'}
local current=1


function menu:load()

end

function menu:update(dt)

end

local Hollirood = love.graphics.newFont('assets/fonts/Hollirood.ttf', 48)
local gmnm = 'wackjack' 

function menu:draw()   
    love.graphics.setFont(Hollirood)
    love.graphics.printf(gmnm,  (love.graphics.getWidth() - Hollirood:getWidth(gmnm)) / 2, (love.graphics.getHeight() - Hollirood:getHeight(gmnm)) / 3.5,Hollirood:getWidth(gmnm), 'center')

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
    love.graphics.setColor(1, 1, 1)
end

function menu:keypressed(key)
    if key == 'down' or key=='up' or key=='w' or key=='s' then
        love.audio.play(sfx.scr)
    elseif key == 'return' or key=='space' then
        love.audio.play(sfx.sel)
    end
    if key=='down' or key=='s' then
        current = (current % #li) + 1
    elseif key=='up' or key=='w' then
        current = current - 1
        if current < 1 then
            current = #li
        end
    elseif key=='return' or key=='space' then
        if current==3 then
            love.graphics.clear()
            currentState=tutorial
        elseif current==4 then
            love.event.quit()
        elseif current==2 then
            love.graphics.clear()
            currentState=options
        elseif current==1 then
            love.graphics.clear()
            currentState=game
        end
    end
end

return menu
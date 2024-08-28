math.randomseed(os.time())
local game = {}

local rank = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"}
local suits = {"hearts", "diamonds", "clubs", "spades"}

local cardset = {}
for i = 1, #rank do
    for j = 1, #suits do
        local mid=rank[i] .. "_of_" .. suits[j]
        table.insert(cardset,mid)
    end
end

sel = nil


-- function pickrandom(cardset)
--     local rindex = math.random(#cardset)
--     return cardset[rindex]
-- end

for i=1, #cardset do
    print(cardset[i])
end

function game:load()

end

function game:update(dt)

end

function game:draw()
    love.graphics.draw(love.graphics.newImage('assets/cards/' .. sel .. '.png'),0,0)
    print(sel)
end

function game:keypressed(key)

end

return game
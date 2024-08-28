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

function pickrandom(cardset)
    return cardset[math.random(#cardset)]
end

local pick=pickrandom(cardset)
print(pick)

local rdaxis = -0.15
local rddist = 125
local dealerHand = 0


for i=1, #cardset do
    --print(cardset[i])
end

function game:load()
    
end

function game:update(dt)

end

function game:draw()
    -- draw bg
    love.graphics.draw(love.graphics.newImage('assets/backgrounds/table.jpg'),0,0,0,1,1)
    love.graphics.print("Dealer's Hand:" .. dealerHand, 10, 10)
    love.graphics.draw(love.graphics.newImage('assets/cards/' .. pick .. '.png'),rddist,125,rdaxis,0.2,0.2,250,363)
end

function game:keypressed(key)
    if key=='h' then
        pick=pickrandom(cardset)
        rdaxis=rdaxis+0.15
        rddist=rddist+50
        print("hit:",pick)
    end
end

return game
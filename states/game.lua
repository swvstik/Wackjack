math.randomseed(os.time())
local game = {}

local rank = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"}
local suits = {"hearts", "diamonds", "clubs", "spades"}

local cardset = {}
for i = 1, #rank do
    for j = 1, #suits do
        local mid = rank[i] .. "_of_" .. suits[j]
        table.insert(cardset, mid)
    end
end

function pickrandom(cardset)
    return cardset[math.random(#cardset)]
end

local dHand = {}
local pHand = {}
local rddist = 125

dealerVal = 0
playerVal = 0

local function dhit()

    rddist = rddist + 50
    local pickedCard = pickrandom(cardset)
    table.insert(pHand, {card = pickedCard, x = rddist, y = 425, rotation = math.random(-15,15)/100})
end

local bgimg = love.graphics.newImage('assets/backgrounds/table.jpg')

function game:load()
    -- Initialize game state if needed
end

function game:update(dt)
    -- Update game state if needed
end

function game:draw()
    -- Draw background
    love.graphics.draw(bgimg, 0, 0, 0, 1, 1)
    -- dealer
    love.graphics.print("Dealer's Hand Value:" .. dealerVal, 10, 10)
    -- player
    love.graphics.print("Player's Hand Value:" .. playerVal, 10, 300)
        for i, card in ipairs(pHand) do
        love.graphics.draw(
            love.graphics.newImage('assets/cards/' .. card.card .. '.png'),
            card.x,
            card.y,
            card.rotation,
            0.2,
            0.2,
            250, 363
        )
    end


end

function game:keypressed(key)
    if key == 'h' then
        dhit()
        print("hit:", pHand[#pHand].card)
    end
    if key == 's' then
        -- stand
    end
end

print(collectgarbage("count"))
collectgarbage("collect")
return game
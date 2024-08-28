math.randomseed(os.time())  -- Seed the random number generator

local game = {}

local rank = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"}
local suits = {"hearts", "diamonds", "clubs", "spades"}

-- Function to get the value of a card based on its rank
local function getCardVal(cardRank)
    if cardRank == "ace" then
        return 11
    elseif cardRank == "jack" or cardRank == "queen" or cardRank == "king" then
        return 10
    else
        return tonumber(cardRank)
    end
end

local faceDownCard = love.graphics.newImage('assets/cards/facedown.png')

-- Create the cardset with card descriptions and values
local cardset = {}
for i = 1, #rank do
    for j = 1, #suits do
        local cardRank = rank[i]
        local cardName = cardRank .. "_of_" .. suits[j]
        local cardVal = getCardVal(cardRank)
        table.insert(cardset, {cardName, cardVal})
    end
end


for _, card in ipairs(cardset) do
    print(card[1], card[2])
end

local function pickRandom(cardset)
    return cardset[math.random(#cardset)]
end

local dHand = {}
local pHand = {}
local rddist = 125
local dealerVal = 0
local playerVal = 0

local function updatePlayerVal()
    playerVal = 0
    for _, card in ipairs(pHand) do
        playerVal = playerVal + card.value
    end
end


local function dhit()
    rddist = rddist + 50
    local pickedCard = pickRandom(cardset)
    table.insert(pHand, {card = pickedCard[1], value = pickedCard[2], x = rddist, y = 425, rotation = math.random(-15, 15) / 100})
    updatePlayerVal()
end

-- Load background image
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
    -- Draw dealer hand value
    love.graphics.print("Dealer's Hand Value: " .. dealerVal, 10, 10)
    -- Draw player hand value
    love.graphics.print("Player's Hand Value: " .. playerVal, 10, 300)
    -- Draw player cards
    for _, card in ipairs(pHand) do
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
        -- Stand logic here
    end
end

-- Clean up
print(collectgarbage("count"))
collectgarbage("collect")

return game

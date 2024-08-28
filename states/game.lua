math.randomseed(os.time())

local game = {}

local ranks = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"}
local suits = {"hearts", "diamonds", "clubs", "spades"}

local faceDownCard = love.graphics.newImage('assets/cards/facedown.png')

local function getCardValue(cardRank)
    if cardRank == "ace" then
        return 11
    elseif cardRank == "jack" or cardRank == "queen" or cardRank == "king" then
        return 10
    else
        return tonumber(cardRank)
    end
end

local function getRandomRotation()
    return math.random(-15, 15) / 100
end

local function createDeck()
    local deck = {}
    for i = 1, #ranks do
        for j = 1, #suits do
            local cardRank = ranks[i]
            local cardName = cardRank .. "_of_" .. suits[j]
            local cardValue = getCardValue(cardRank)
            table.insert(deck, {name = cardName, value = cardValue, rotation = getRandomRotation()})
        end
    end
    return deck
end

local function pickRandomCard(deck)
    return table.remove(deck, math.random(#deck))
end

local function calculateHandValue(hand)
    local value = 0
    local aces = 0
    for _, card in ipairs(hand) do
        value = value + card.value
        if card.value == 11 then aces = aces + 1 end
    end
    while value > 21 and aces > 0 do
        value = value - 10
        aces = aces - 1
    end
    return value
end

local function dealInitialCards()
    dealerHand = {pickRandomCard(deck), pickRandomCard(deck)}
    playerHand = {pickRandomCard(deck), pickRandomCard(deck)}
    dealerValue = dealerHand[2].value
    playerValue = calculateHandValue(playerHand)
end

local function dealerPlay()
    dealerFaceDown = false
    dealerValue = calculateHandValue(dealerHand)
    while dealerValue < 17 do
        table.insert(dealerHand, pickRandomCard(deck))
        dealerValue = calculateHandValue(dealerHand)
    end
    if dealerValue > 21 or dealerValue < playerValue then
        gameResult = "Player Wins!"
    elseif dealerValue > playerValue then
        gameResult = "Dealer Wins!"
    else
        gameResult = "Draw!"
    end
end

local function checkPlayerStatus()
    if playerValue > 21 then
        gameResult = "Player Busts! Dealer Wins!"
        playerStand = true
    elseif playerValue == 21 then
        gameResult = "Blackjack! Player Wins!"
        playerStand = true
    end
end

local actionLog = ''

local function resetGame()
    deck = createDeck()
    dealerHand = {}
    playerHand = {}
    dealerValue = 0
    playerValue = 0
    playerStand = false
    dealerFaceDown = true
    gameResult = nil
    actionLog=''
    dealInitialCards()
end

bgimg = love.graphics.newImage('assets/backgrounds/table.jpg')
resetGame()
checkPlayerStatus()


function game:load()
    
end

function game:update(dt)
    if playerStand and not gameResult then
        dealerPlay()
    end
end

function game:draw()
    love.graphics.draw(bgimg, 0, 0)

    love.graphics.print("Dealer's Hand: "..dealerValue, 10, 10)
    for i, card in ipairs(dealerHand) do
        if i == 1 and dealerFaceDown then
            love.graphics.draw(faceDownCard, 50 + (i-1) * 80, 100, card.rotation, 0.2, 0.2, 100, 145.2)
        else
            love.graphics.draw(love.graphics.newImage('assets/cards/' .. card.name .. '.png'),50 + (i-1) * 80,100,card.rotation,0.2,0.2,100, 145.2)
        end
    end

    love.graphics.print("Player's Hand: ".. playerValue, 10, 300)
    for i, card in ipairs(playerHand) do
        love.graphics.draw(love.graphics.newImage('assets/cards/' .. card.name .. '.png'),50 + (i-1) * 80,380,card.rotation,0.2,0.2,100, 145.2)
    end

    if gameResult then
        love.graphics.print(gameResult .. "\nPress ESC to go back to the menu! Press R to restart!", 10, 540)
    else
        love.graphics.printf(actionLog, 400, 550,50,'center')
    end
end

function game:keypressed(key)
    if key == 'h' and not playerStand then
        table.insert(playerHand, pickRandomCard(deck))
        playerValue = calculateHandValue(playerHand)
        actionLog='Hit!'
        checkPlayerStatus()
    elseif key == 's' and not playerStand then
        playerStand = true
    elseif key == 'escape' then
        resetGame()
        currentState = menu
    elseif key == 'r' then
        resetGame()
    end
end

return game

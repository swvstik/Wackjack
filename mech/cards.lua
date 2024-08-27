local cards = {}

function loadCardImages()
    local cardTypes = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"}
    local suits = {"hearts", "diamonds", "clubs", "spades"}

    -- Load facedown card
    cards["facedown"] = love.graphics.newImage("assets/cards/facedown.png")


    -- Load numbered cards and face cards
    for _, cardType in ipairs(cardTypes) do
        for _, suit in ipairs(suits) do
            local cardName = cardType .. "_of_" .. suit
            -- Load card image
            if love.filesystem.getInfo("assets/cards/" .. cardName .. ".png") then
                cards[cardName] = love.graphics.newImage("assets/cards/" .. cardName .. ".png")
            end
        end
    end
end

function getCardImage(name)
    return cards[name]
end

return {
    loadCardImages = loadCardImages,
    getCardImage = getCardImage
}

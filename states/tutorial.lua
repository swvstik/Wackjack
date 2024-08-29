tutorial = {}

function tutorial:load()
end

function tutorial:update(dt)
end

function tutorial:draw()
    love.graphics.setColor(0.7,0.7,0.7)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.printf("Tutorial: The game starts with a player and a dealer. The player is dealt two cards, and the dealer is dealt one card. The player can choose to hit or stand. If the player's total is over 21, they lose. If the player stands, the dealer draws cards until their total is 17 or higher. The player with the highest total without going over 21 wins.\n\nControls: arrow-keys or WASD to navigate menu and options, 'h' to hit and 's' to stand in-game, 'esc' to return to menu, 'r' to restart the game.",100,100,600,'center')
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.setColor(1,1,1)
    love.graphics.printf("< press esc to return to menu >",100,400,600,'center')
end

function tutorial:keypressed(key)
    if key == 'escape' then
        love.graphics.clear()
        currentState=menu
    end
end

return tutorial
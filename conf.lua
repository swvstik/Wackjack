function love.conf(t)
    t.window.width = 800
    t.window.height = 600
    t.window.resizable=false
    t.vsync=true
    t.window.borderless=true
    -- game details
    t.title = 'wackjack'
    t.version = '11.0'
    t.console=true
    print(collectgarbage("count"))  -- Prints memory usage in KB
collectgarbage("collect")
end
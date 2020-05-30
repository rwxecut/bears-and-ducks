local function init(love)
    local function load()
        local window_width = 800
        local window_height = 600
        love.window.setMode(window_width, window_height, nil)

        CHAR = {}
        CHAR.width = 16
        CHAR.height = 32
        CHAR.x = window_width / 2
        CHAR.y = window_height / 2

        MOUSE = {}
        MOUSE.x, MOUSE.y = love.mouse.getPosition()
    end

    return load
end

return init

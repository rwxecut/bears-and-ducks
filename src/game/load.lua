local function init(love)
    local function load()
        window_width = 800
        window_height = 600
        love.window.setMode(window_width, window_height, nil)

        char_width = 16
        char_height = 32
        char_x = window_width / 2
        char_y = window_height / 2
    end

    return load
end

return init

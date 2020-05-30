local function init(love)
    local function draw()
        love.graphics.rectangle("fill",
            char_x, char_y,
            char_width, char_height,
            10)
    end

    return draw
end

return init

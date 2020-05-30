local function init(love)
    local function draw()
        love.graphics.rectangle("fill",
            CHAR.x, CHAR.y,
            CHAR.width, CHAR.height,
            10)
    end

    return draw
end

return init

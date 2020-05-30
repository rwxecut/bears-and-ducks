local function init(love)
    local function draw()
        love.graphics.print('The Bears And The Ducks', 400, 300)
    end

    return draw
end

return init

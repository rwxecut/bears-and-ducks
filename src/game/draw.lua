local function draw()
    CHAR.camera:attach()

    love.graphics.rectangle("fill",
        CHAR.x, CHAR.y,
        CHAR.width, CHAR.height,
        4)

    for dot_x = -(GRID.width / 2), GRID.width / 2, GRID.step do
        for dot_y = -(GRID.height / 2), GRID.height / 2, GRID.step do
            love.graphics.points (dot_x, dot_y)
        end
    end

    CHAR.camera:detach()
end

return draw

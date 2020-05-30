local function draw()
    CHAR.camera:attach()

    Love.graphics.setColor (1, 1, 1)

    Love.graphics.rectangle("fill",
        CHAR.x - CHAR.width / 2, CHAR.y - CHAR.height / 2,
        CHAR.width, CHAR.height,
        4)

    Love.graphics.setColor(unpack(GRID.color))

    GRID.x0, GRID.y0 = CHAR.camera:position()
    GRID.x0 = GRID.x0 - GRID.x0 % GRID.step
    GRID.y0 = GRID.y0 - GRID.y0 % GRID.step
    GRID.radius = GRID.base_radius / CHAR.camera.scale
    GRID.x1 = GRID.x0 - GRID.radius
    GRID.y1 = GRID.y0 - GRID.radius
    GRID.x2 = GRID.x0 + GRID.radius
    GRID.y2 = GRID.y0 + GRID.radius

    for dot_x = GRID.x1, GRID.x2, GRID.step do
        for dot_y = GRID.y1, GRID.y2, GRID.step do
            Love.graphics.points (dot_x, dot_y)
        end
    end

    CHAR.camera:detach()
end

return draw

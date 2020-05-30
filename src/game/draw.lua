local function draw()
    CHAR.camera:attach()

    Love.graphics.rectangle("fill",
        CHAR.x, CHAR.y,
        CHAR.width, CHAR.height,
        10)

    Love.graphics.rectangle("fill", 50, 50, 10, 10, 10)

    Love.graphics.rectangle("fill", 700, 50, 10, 10, 10)

    Love.graphics.rectangle("fill", 50, 500, 10, 10, 10)

    Love.graphics.rectangle("fill", 700, 500, 10, 10, 10)

    CHAR.camera:detach()
end

return draw

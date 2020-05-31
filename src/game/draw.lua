local function draw()
    CAM:attach()

    GRID:draw(CAM)
    PLATFORM:draw()
    PLATFORM2:draw()

    CHAR:draw()

    CAM:detach()
end

return draw

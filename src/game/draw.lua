local function draw()
    CAM:attach()

    GRID:draw(CAM)
    PLATFORM:draw()
    CHAR:draw()

    CAM:detach()
end

return draw

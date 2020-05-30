local function draw()
    CAM:attach()

    GRID:draw(CAM)
    PLATFORM:draw()

    SPRITES.duck:drawArbitrary(50, 50)

    SPRITES.platform_h:drawArbitrary(100, 150)
    SPRITES.platform_left_top:drawArbitrary(132, 150)
    SPRITES.platform_v:drawArbitrary(132, 118)

    CHAR:draw()

    CAM:detach()
end

return draw

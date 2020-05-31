local function draw()
    CAM:attach()

    GRID:draw(CAM)
    PLATFORM:draw()

    SPRITES.duck:drawArbitrary(50, 50)

    SPRITES.platform_lr:drawArbitrary(100, 150)
    SPRITES.platform_tl:drawArbitrary(132, 150)
    SPRITES.platform_tb:drawArbitrary(132, 118)

    SPRITES.bear:drawArbitrary(300, 200)

    CHAR:draw()

    CAM:detach()
end

return draw

local function draw()
    CAM:attach()

    GRID:draw(CAM)
    PLATFORM:draw()

    SPRITES.duck:drawArbitrary(50, 50)


    local x, y = 100, 100

    SPRITES.platform_b:drawArbitrary(x - 32, y - 32)

    SPRITES.platform_tr:drawArbitrary(x - 32, y)
    SPRITES.platform_blr:drawArbitrary(x, y)
    SPRITES.platform_bl:drawArbitrary(x + 32, y)

    SPRITES.platform_t:drawArbitrary(x, y + 32)
    SPRITES.platform_tb:drawArbitrary(x + 32, y + 32)

    SPRITES.platform_t:drawArbitrary(x + 32, y + 64)

    SPRITES.bear:drawArbitrary(300, 200)

    CHAR:draw()

    CAM:detach()
end

return draw

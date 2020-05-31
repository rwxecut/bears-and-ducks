local function draw()
    CAM:attach()

    SC:draw(CAM)

    CAM:detach()

    UI:draw()
end

return draw

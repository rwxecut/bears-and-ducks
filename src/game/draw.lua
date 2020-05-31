local function draw()
    CAM:attach()

    STAGES._current_stage:draw(CAM)

    CAM:detach()

    UI:draw()
end

return draw

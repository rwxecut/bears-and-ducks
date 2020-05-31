local function update(dt)
    MOUSE.world_x, MOUSE.world_y = CAM:worldCoords(MOUSE.window_x, MOUSE.window_y)

    local char = STAGES._current_stage.character
    char:updateVelocity()
    char:moveSelf(dt)

    local dx, dy = char.x - CAM.x, char.y - CAM.y
    CAM:move(dx/2, dy/2)

    CAM:zoomMakeStep()
end

return update

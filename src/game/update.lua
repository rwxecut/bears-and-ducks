local function update(dt)
    MOUSE.world_x, MOUSE.world_y = CAM:worldCoords(MOUSE.window_x, MOUSE.window_y)

    local velocity_x = MOUSE.world_x - CHAR.x
    CHAR.x = CHAR.x + velocity_x * dt

    local dx, dy = CHAR.x - CAM.x, CHAR.y - CAM.y
    CAM:move(dx/2, dy/2)

    CAM:zoomMakeStep()
end

return update

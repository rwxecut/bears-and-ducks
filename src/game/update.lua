local function update(dt)
    MOUSE.world_x, MOUSE.world_y = CAM:worldCoords(MOUSE.window_x, MOUSE.window_y)

    CHAR:updateVelocity()
    CHAR:moveSelf(dt)

    local dx, dy = CHAR.x - CAM.x, CHAR.y - CAM.y
    CAM:move(dx/2, dy/2)

    CAM:zoomMakeStep()
end

return update

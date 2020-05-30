local function update(dt)
    MOUSE.world_x, MOUSE.world_y = CAM:worldCoords(MOUSE.window_x, MOUSE.window_y)

    local velocity_x = MOUSE.world_x - CHAR.x
    local velocity_y = MOUSE.world_y - CHAR.y
    CHAR.x = CHAR.x + velocity_x * dt
    CHAR.y = CHAR.y + velocity_y * dt

    local dx, dy = CHAR.x - CAM.x, CHAR.y - CAM.y
    CAM:move(dx/2, dy/2)

    if CAM._zoom_current < CAM._zoom_desired then
        CAM:zoomTo(CAM.scale * 1.1)
        CAM._zoom_current = CAM._zoom_current + 1
    elseif CAM._zoom_current > CAM._zoom_desired then
        CAM:zoomTo(CAM.scale / 1.1)
        CAM._zoom_current = CAM._zoom_current - 1
    end
end

return update

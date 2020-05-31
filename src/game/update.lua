local function update(dt)
    MOUSE.world_x, MOUSE.world_y = CAM:worldCoords(MOUSE.window_x, MOUSE.window_y)

    local stage = SC:getCurrent()
    stage.character:updateVelocity()
    stage.character:moveSelf(dt, stage.phys)

    local dx, dy = stage.character.x - CAM.x, stage.character.y - CAM.y
    CAM:move(dx/2, dy/2)

    CAM:zoomMakeStep()
end

return update

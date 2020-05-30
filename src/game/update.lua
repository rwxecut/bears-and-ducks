local function init(love)
    local function update(dt)
        MOUSE.world_x, MOUSE.world_y = CHAR.camera:worldCoords(MOUSE.window_x, MOUSE.window_y)

        local velocity_x = MOUSE.world_x - CHAR.x
        local velocity_y = MOUSE.world_y - CHAR.y
        CHAR.x = CHAR.x + velocity_x * dt
        CHAR.y = CHAR.y + velocity_y * dt

        local dx, dy = CHAR.x - CHAR.camera.x, CHAR.y - CHAR.camera.y
        CHAR.camera:move(dx/2, dy/2)
    end

    return update
end

return init

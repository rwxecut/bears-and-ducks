local function init(love)
    local function update(dt)
        local vec_x = MOUSE.x - CHAR.x
        local vec_y = MOUSE.y - CHAR.y
        CHAR.x = CHAR.x + vec_x * dt
        CHAR.y = CHAR.y + vec_y * dt
    end

    return update
end

return init

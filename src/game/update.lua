local function init(love)
    local function update(dt)
        local cur_x, cur_y = love.mouse.getPosition()
        vec_x = cur_x - char_x
        vec_y = cur_y - char_y
        char_x = char_x + vec_x * dt
        char_y = char_y + vec_y * dt
    end

    return update
end

return init

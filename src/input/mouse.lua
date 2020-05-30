local function init(love)
    local function mousepressed(x, y, button, istouch)

    end


    local function mousereleased(x, y, button, istouch)

    end

    local function mousemoved(x, y, dx, dy, istouch)
        MOUSE.x = x
        MOUSE.y = y
    end

    return {
        mousepressed = mousepressed,
        mousereleased = mousereleased,
        mousemoved = mousemoved,
    }
end

return init

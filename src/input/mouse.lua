local function mousepressed(x, y, button, istouch)

end


local function mousereleased(x, y, button, istouch)

end

local function mousemoved(x, y, dx, dy, istouch)
    MOUSE.window_x = x
    MOUSE.window_y = y
end

local function wheelmoved(x, y)
    if y > 0 then
        CHAR.camera:zoomTo(CHAR.camera.scale * 1.1)
    elseif y < 0 then
        CHAR.camera:zoomTo(CHAR.camera.scale / 1.1)
    end
end

return {
    mousepressed = mousepressed,
    mousereleased = mousereleased,
    mousemoved = mousemoved,
    wheelmoved = wheelmoved,
}

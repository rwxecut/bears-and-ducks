local function mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        MOUSE.pressed_1 = true
    end
end


local function mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        MOUSE.pressed_1 = false
    end
end


local function mousemoved(x, y, dx, dy, istouch)
    MOUSE.x_window = x
    MOUSE.y_window = y
end


local function wheelmoved(x, y)
    CAM:zoomUpdateFromWheel(y)
end


return {
    mousepressed = mousepressed,
    mousereleased = mousereleased,
    mousemoved = mousemoved,
    wheelmoved = wheelmoved,
}

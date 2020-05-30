local function mousepressed(x, y, button, istouch)

end


local function mousereleased(x, y, button, istouch)

end


local function mousemoved(x, y, dx, dy, istouch)
    MOUSE.window_x = x
    MOUSE.window_y = y
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

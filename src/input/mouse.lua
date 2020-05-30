local function mousepressed(x, y, button, istouch)

end


local function mousereleased(x, y, button, istouch)

end


local function mousemoved(x, y, dx, dy, istouch)
    MOUSE.window_x = x
    MOUSE.window_y = y
end


local function wheelmoved(x, y)
    CAM._zoom_desired = CAM._zoom_desired + y
    if CAM._zoom_desired > CAM._zoom_max then
        CAM._zoom_desired = CAM._zoom_max
    elseif CAM._zoom_desired < CAM._zoom_min then
        CAM._zoom_desired = CAM._zoom_min
    end
end


return {
    mousepressed = mousepressed,
    mousereleased = mousereleased,
    mousemoved = mousemoved,
    wheelmoved = wheelmoved,
}

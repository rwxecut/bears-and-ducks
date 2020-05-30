local function mousepressed(x, y, button, istouch)

end


local function mousereleased(x, y, button, istouch)

end


local function mousemoved(x, y, dx, dy, istouch)
    MOUSE.window_x = x
    MOUSE.window_y = y
end


local function wheelmoved(x, y)
    CAM.zoom_desired = CAM.zoom_desired + y
    if CAM.zoom_desired > CAM.zoom_max then
        CAM.zoom_desired = CAM.zoom_max
    elseif CAM.zoom_desired < CAM.zoom_min then
        CAM.zoom_desired = CAM.zoom_min
    end
end


return {
    mousepressed = mousepressed,
    mousereleased = mousereleased,
    mousemoved = mousemoved,
    wheelmoved = wheelmoved,
}

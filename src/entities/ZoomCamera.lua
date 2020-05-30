local ZoomCamera = {
    zoom_min = -5,
    zoom_max = 5,
    zoom_current = 0,
    zoom_desired = 0,
}

function ZoomCamera:new(a, b, c, d, e)
    local t = self
    t.camera = Camera(a, b, c, d, e)

    -- Search for fields in camera when they are not present in ZoomCamera
    setmetatable(t, {__index = t.camera})

    return t
end

return ZoomCamera

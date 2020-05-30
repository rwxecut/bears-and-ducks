local ZoomCamera = {
    zoom_min = -5,
    zoom_max = 5,
    zoom_current = 0,
    zoom_desired = 0,
    zoom_multiplier = 1.1,
    rotation_step = math.pi / 12,
}

function ZoomCamera:new(a, b, c, d, e)
    local t = self
    t.camera = Camera(a, b, c, d, e)

    -- Search for fields in camera when they are not present in ZoomCamera
    setmetatable(t, {__index = t.camera})

    return t
end

function ZoomCamera:zoomUpdateFromWheel(steps)
    self.zoom_desired = self.zoom_desired + steps
    if self.zoom_desired > self.zoom_max then
        self.zoom_desired = self.zoom_max
    elseif self.zoom_desired < self.zoom_min then
        self.zoom_desired = self.zoom_min
    end
end

function ZoomCamera:zoomMakeStep()
    if self.zoom_current < self.zoom_desired then
        self:zoomTo(self.scale * self.zoom_multiplier)
        self.zoom_current = self.zoom_current + 1
    elseif self.zoom_current > self.zoom_desired then
        self:zoomTo(self.scale / self.zoom_multiplier)
        self.zoom_current = self.zoom_current - 1
    end
end

function ZoomCamera:rotateClockwise(angle)
    self:rotate(angle or self.rotation_step)
end

function ZoomCamera:rotateCounterclockwise(angle)
    self:rotate(angle or -self.rotation_step)
end

return ZoomCamera

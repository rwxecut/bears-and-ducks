local Grid = {
    radius = 0,
    step = 0,
    color = {0.5, 0.5, 0.5}
}

Grid.__index = Grid

function Grid:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end

function Grid:draw(camera)
    local color_before = {Love.graphics.getColor()}

    Love.graphics.setColor(unpack(self.color))

    local x0, y0 = camera:position()
    x0 = x0 - x0 % self.step
    y0 = y0 - y0 % self.step

    local scaled_radius = self.radius / camera.scale
    local x1, y1 = x0 - scaled_radius, y0 - scaled_radius
    local x2, y2 = x0 + scaled_radius, y0 + scaled_radius

    for dot_x = x1, x2, self.step do
        for dot_y = y1, y2, self.step do
            Love.graphics.points(dot_x, dot_y)
        end
    end

    Love.graphics.setColor(unpack(color_before))
end

return Grid

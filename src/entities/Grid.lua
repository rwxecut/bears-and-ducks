local Grid = {
    radius = 0,
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

    local scaled_radius = self.radius / camera.scale
    local x1, y1 = Cell.nearest(x0 - scaled_radius, y0 - scaled_radius):pos()
    local x2, y2 = Cell.nearest(x0 + scaled_radius, y0 + scaled_radius):pos()

    for dot_x = x1, x2, Cell.size do
        for dot_y = y1, y2, Cell.size do
            Love.graphics.points(dot_x, dot_y)
        end
    end

    Love.graphics.setColor(unpack(color_before))
end

return Grid

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

function Grid:cellByCoords(x, y)
    return math.floor(x / self.step), math.floor(y / self.step)
end

function Grid:coordsByCell(cell_x, cell_y)
    return cell_x * self.step, cell_y * self.step
end

function Grid:localCellCoords(x, y)
    return self:coordsByCell(self:cellByCoords(x, y))
end

function Grid:draw(camera)
    local color_before = {Love.graphics.getColor()}

    Love.graphics.setColor(unpack(self.color))

    local x0, y0 = camera:position()

    local scaled_radius = self.radius / camera.scale
    local x1, y1 = self:localCellCoords(x0 - scaled_radius, y0 - scaled_radius)
    local x2, y2 = self:localCellCoords(x0 + scaled_radius, y0 + scaled_radius)

    for dot_x = x1, x2, self.step do
        for dot_y = y1, y2, self.step do
            Love.graphics.points(dot_x, dot_y)
        end
    end

    Love.graphics.setColor(unpack(color_before))
end

return Grid

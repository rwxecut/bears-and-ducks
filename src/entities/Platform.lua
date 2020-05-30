local Platform = {
    x = 0,
    y = 0,
    width = 0,
}

Platform.__index = Platform

function Platform:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end

function Platform:draw()
    local color_before = {Love.graphics.getColor()}

    Love.graphics.setColor(1, 1, 1)
    Love.graphics.line(self.x, self.y, self.x + self.width, self.y)

    Love.graphics.setColor(unpack(color_before))
end

return Platform

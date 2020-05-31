local Stage = {
    platforms = {},
    grid = nil,
    character = nil,
}

Stage.__index = Stage

function Stage:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end

function Stage:draw(camera)
    local color_before = {Love.graphics.getColor()}

    self.grid:draw(camera)

    for i = 1, #self.platforms do
        self.platforms[i]:draw()
    end

    if self.character ~= nil then
        self.character:draw()
    end

    Love.graphics.setColor(unpack(color_before))
end

function Stage:_addPlatform(p)
    table.insert(self.platforms, p)
end

return Stage

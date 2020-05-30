local Character = {
    width = 2,
    height = 4,
    x = 0,
    y = 0,
    color_base = {0.8, 0.5, 0.5},
    color_accent = {0.3, 0.3, 0.3},
}

Character.__index = Character

function Character:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end

function Character:moveToCell(cell)
    self.x, self.y = cell:pos()
end

function Character:draw(camera)
    local color_before = {Love.graphics.getColor()}

    Love.graphics.setColor(unpack(self.color_base))

    Love.graphics.rectangle(
        "fill",
        self.x,
        self.y - Cell.realHeight(self),
        Cell.realWidth(self),
        Cell.realHeight(self),
        4)

    Love.graphics.setColor(unpack(self.color_accent))

    -- Assuming height = width * 2 here
    Love.graphics.circle(
        "fill",
        self.x + Cell.realWidth(self) / 2,
        self.y - Cell.realHeight(self) * 3 / 4,
        Cell.realWidth(self) / 4
    )

    Love.graphics.setColor(unpack(color_before))
end

return Character

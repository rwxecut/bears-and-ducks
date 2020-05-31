local Character = {
    width = 2,
    height = 4,
    x = 0,
    y = 0,
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

function Character:draw()
    local color_before = {Love.graphics.getColor()}

    -- Note  "- Cell.realWidth(self)/2".
    -- This is to draw the bear in the center of the screen and may cause problems.
    SPRITES.bear:drawArbitrary(self.x - Cell.realWidth(self)/2, self.y - Cell.realHeight(self))

    Love.graphics.setColor(unpack(color_before))
end

return Character

local Character = {
    width = 0,
    height = 0,
    x = 0,
    y = 0,
    color_base = {0.8, 0.5, 0.5},
    color_accent = {0.3, 0.3, 0.3},
}

function Character:new(t)
    local o = t or self
    setmetatable(o, {__index = self})
    self.__index = self
    return o
end

function Character:draw(camera)
    local color_before = {Love.graphics.getColor()}

    Love.graphics.setColor(unpack(self.color_base))

    Love.graphics.rectangle(
        "fill",
        self.x - self.width / 2,
        self.y - self.height,
        self.width,
        self.height,
        4)

    Love.graphics.setColor(unpack(self.color_accent))

    -- Assuming height = width * 2 here
    Love.graphics.circle(
        "fill",
        self.x,
        self.y - self.height * 3 / 4,
        self.width / 4
    )

    Love.graphics.setColor(unpack(color_before))
end

return Character

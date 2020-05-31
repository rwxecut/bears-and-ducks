local Character = {
    width = 2,
    height = 4,
    x = 0,
    y = 0,
    color_base = {0.8, 0.5, 0.5},
    color_accent = {0.3, 0.3, 0.3},

    speed = vector(0, 0),
    run_accel = 10
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

function Character:updateSpeed()
    local new_speed = vector(0, 0)

    --- Own movement
    local wanted_run_speed = MOUSE.world_x - self.x
    new_speed.x = wanted_run_speed

    self.speed = new_speed
end

function Character:moveSelf(dt)
    self.x = self.x + self.speed.x * dt
    self.y = self.y + self.speed.y * dt
end

function Character:draw(camera)
    local color_before = {Love.graphics.getColor()}

    -- Note  "- Cell.realWidth(self)/2".
    -- This is to draw the bear in the center of the screen and may cause problems.
    SPRITES.bear:drawArbitrary(self.x - Cell.realWidth(self)/2, self.y - Cell.realHeight(self))

    Love.graphics.setColor(unpack(color_before))
end

return Character

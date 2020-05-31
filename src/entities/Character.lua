local Character = {
    width = 2,
    height = 4,
    x = 0,
    y = 0,
    color_base = {0.8, 0.5, 0.5},
    color_accent = {0.3, 0.3, 0.3},

    velocity = vector(0, 0),
    run_accel = 3,
    fall_accel = 9.8,
    term_vel = 53,
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

function Character:updateVelocity()
    local new_vel = self.velocity

    --- Own movement
    local wanted_run_vel = MOUSE.world_x - self.x
    local run_vel_to_gain = wanted_run_vel - self.velocity.x

    if run_vel_to_gain > 0 then
        new_vel.x = new_vel.x + math.min(self.run_accel, run_vel_to_gain)
    elseif run_vel_to_gain < 0 then
        new_vel.x = new_vel.x + math.max(-self.run_accel, run_vel_to_gain)
    end

    --- External forces
    local fall_vel_to_gain = self.term_vel - self.velocity.y

    if fall_vel_to_gain > 0 then
        new_vel.y = new_vel.y + math.min(self.fall_accel, fall_vel_to_gain)
    end

    --- Collisions

    self.velocity = new_vel
end

function Character:moveSelf(dt)
    self.x = self.x + self.velocity.x * dt
    self.y = self.y + self.velocity.y * dt
end

function Character:draw(camera)
    local color_before = {Love.graphics.getColor()}

    -- Note  "- Cell.realWidth(self)/2".
    -- This is to draw the bear in the center of the screen and may cause problems.
    SPRITES.bear:drawArbitrary(self.x - Cell.realWidth(self)/2, self.y - Cell.realHeight(self))

    Love.graphics.setColor(unpack(color_before))
end

return Character

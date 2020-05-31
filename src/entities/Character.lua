local Cellular = require "src.entities.Cellular"


local Character = Cellular:new {
    width = 2,
    height = 4,
    color_base = {0.8, 0.5, 0.5},
    color_accent = {0.3, 0.3, 0.3},

    velocity = Vector(0, 0),
    run_accel = 3,
    fall_accel = 9.8,
    term_vel = 53,
}


function Character:moveToCell(cell)
    local cx, cy = cell:pos()
    self.x = cx
    self.y = cy - self:realHeight()
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


function Character:moveSelf(dt, phys)
    local target_x = self.x + self.velocity.x * dt
    local target_y = self.y + self.velocity.y * dt

    local actual_x, actual_y = phys:move(self, target_x, target_y)
    local actual_vel_x = (actual_x - self.x) / dt
    local actual_vel_y = (actual_y - self.y) / dt

    self.x, self.y = actual_x, actual_y
    self.velocity = Vector(actual_vel_x, actual_vel_y)
end


function Character:draw()
    local color_before = {Love.graphics.getColor()}

    SPRITES.bear:drawArbitrary(self.x, self.y)

    Love.graphics.setColor(unpack(color_before))
end


return Character

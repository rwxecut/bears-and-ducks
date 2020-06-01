local log = Logger:new {
    component = "Character",
    -- enable_debug = true,
}


local Cellular = require "src.entities.Cellular"


local Character = Cellular:new {
    dim = Vector(2, 4),

    vel = Vector(0, 0),

    -- terminal velocity
    vel_min = {
        x = -4,
        y = -53,
    },
    vel_max = {
        x = 4,
        y = 53,
    },

    accel_running = Vector(3, 0),
    accel_always = Vector(0, 9.8),

    jump_is_standing = false,
    jump_is_ascending = false,
    jump_vel_initial = Vector(0, -10),
    jump_vel_interruption = Vector(0, -4),
}


local function limit(limits, other)
    local limited_x = math.min(math.max(limits.min.x, other.x), limits.max.x)
    local limited_y = math.min(math.max(limits.min.y, other.y), limits.max.y)
    return Vector(limited_x, limited_y)
end


function Character:moveSelf(t)
    -- Running
    do
        local vel_change_available_range = {
            min = self.accel_running * t.dt * -1,
            max = self.accel_running * t.dt,
        }

        local vel_want = Vector(t.x_to_approach - self.pos.x, self.vel.y)
        local vel_want_change = vel_want - self.vel

        self.vel = self.vel + limit(vel_change_available_range, vel_want_change)
    end

    -- Falling (always)
    do
        local vel_change_available_range = {
            min = self.accel_always * t.dt,
            max = self.accel_always * t.dt,
        }

        local vel_want = self.vel
        local vel_want_change = self.vel - vel_want

        self.vel = self.vel + limit(vel_change_available_range, vel_want_change)
    end

    -- Jumping
    if t.jump_wanted then
        if self.jump_is_standing then
            self.vel = self.vel + self.jump_vel_initial
            self.jump_is_standing = false
            self.jump_is_ascending = true
        end
    else
        if self.jump_is_ascending then
            Copy.localizeField(self, "vel")
            self.vel.y = math.max(self.vel.y, self.jump_vel_interruption.y)
            self.jump_is_ascending = false
        end
    end

    -- Limiting velocity with terminal velocity
    local vel_limited = limit({min = self.vel_min, max = self.vel_max}, self.vel)

    -- Updating position
    local pos_new_target = self.pos + vel_limited * t.dt

    -- Limiting new position based on collisions
    local phys_x, phys_y, c, c_len = t.phys:move(self, pos_new_target.x, pos_new_target.y)
    local pos_new_limited = Vector(phys_x, phys_y)
    UI.c, UI.c_len = c, c_len

    -- Moving to the new pos
    self.vel = (pos_new_limited - self.pos) / t.dt
    self.pos = pos_new_limited

    -- If we tried to fall
    -- and we didn't descend the full way
    -- then we are standing
    self.jump_is_standing = (vel_limited.y > 0) and (pos_new_limited.y < pos_new_target.y)

    -- If we were ascending __after jump__ and started falling,
    -- we are not ascending __after jump__ anymore
    self.jump_is_ascending = self.jump_is_ascending and self.vel.y < 0
end


function Character:draw()
    local color_before = {Love.graphics.getColor()}

    SPRITES.bear:drawInCell(self)

    Love.graphics.setColor(unpack(color_before))
end


return Character

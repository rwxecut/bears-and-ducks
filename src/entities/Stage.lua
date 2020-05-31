local Stage = {
    platforms = {},
    grid = nil,
    spawn = nil,
    stage_next = nil,
    stage_prev = nil,
}

Stage.__index = Stage


function Stage:new(t)
    local o = t or self
    setmetatable(o, self)

    o:reset()
    return o
end


function Stage:reset()
    -- Resetting the physics to remove old platforms and character
    self.phys = Bump.newWorld(Cell.size)

    self.character = Character:new(self.spawn)
    self.character:addToPhys(self.phys)

    for i = 1, #self.platforms do
        self.platforms[i]:addToPhys(self.phys)
    end
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

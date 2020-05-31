local log = Logger:new {
    component = "Stage"
}


local stage_id_counter = 1


local Stage = {}


function Stage:new(t)
    local o = Construct(self, t)
    o._id = "s" .. stage_id_counter
    stage_id_counter = stage_id_counter + 1
    o:reset()
    return o
end


function Stage:reset()
    log:info("Resetting stage <" .. self._id .. ">")
    self.phys = Bump.newWorld(Cell.size)
    self.phys._id = self._id

    self.character = Character:new({x = self.spawn.x, y = self.spawn.y})
    self.character:addToPhys(self.phys)

    self.platform_g:addToPhys(self.phys)
end


function Stage:draw(camera)
    local color_before = {Love.graphics.getColor()}

    self.grid:draw(camera)

    self.platform_g:draw()

    if self.character ~= nil then
        self.character:draw()
    end

    Love.graphics.setColor(unpack(color_before))
end


return Stage

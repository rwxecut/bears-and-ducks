local log = Logger:new {
    component = "Stage"
}


local stage_id_counter = 1


local Stage = {
    spawn = Cellular:new(),
    character = Character:new(),
    platform_g = PlatformGroup:new(),
    phys = nil, -- generated in :reset()
}


function Stage:new(t)
    local o = Construct(self, t)
    o._id = "s" .. stage_id_counter
    stage_id_counter = stage_id_counter + 1
    o:reset()
    return o
end


function Stage:reset()
    log:info("resetting stage <" .. self._id .. ">")

    self.phys = Bump.newWorld(CONSTS.cell_side_real)
    self.phys._pg_id = self._id

    self.character = Character:new {
        pos = self.spawn.pos
    }
    self.character:addToPhys(self.phys)

    self.platform_g:addToPhys(self.phys)
end


function Stage:draw(camera)
    local color_before = {Love.graphics.getColor()}

    self.platform_g:draw()
    self.character:draw()

    Love.graphics.setColor(unpack(color_before))
end


return Stage

local log = Logger:new {
    component = "Cellular",
}


local cellular_id_counter = 1


local Cellular = {
    pos = Vector(0, 0),
    dim = Vector(1, 1),
}


function Cellular:new(t)
    local o = Construct(self, t)
    o._id = "cellular" .. cellular_id_counter
    cellular_id_counter = cellular_id_counter + 1
    return o
end


function Cellular:newAligned(pos)
    return self:new {
        pos = Vector(math.floor(pos.x), math.floor(pos.y))
    }
end


function Cellular:newAlignedFromReal(pos_real)
    return self:new {
        pos = Vector(
            math.floor(pos_real.x / CONSTS.cell_side_real),
            math.floor(pos_real.y / CONSTS.cell_side_real)
        )
    }
end


function Cellular:realPos()
    return self.pos * CONSTS.cell_side_real
end


function Cellular:realDim()
    return self.dim * CONSTS.cell_side_real
end


function Cellular:addToPhys(phys)
    log:info("adding <" .. self._id .. "> to phys of <" .. phys._pg_id .. ">")
    log:debug("pos: " .. self.pos.x .. " " .. self.pos.y)
    log:debug("dim: " .. self.dim.x .. " " .. self.dim.y)
    phys:add(self, self.pos.x, self.pos.y, self.dim.x, self.dim.y)
end


return Cellular

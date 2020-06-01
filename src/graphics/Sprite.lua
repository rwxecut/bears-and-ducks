local Tile = {
    atlas = nil, -- generated in :new()
    atlas_p = nil, -- generated in :new()
    scale = 4,
}


function Tile:new(t)
    assert(t.atlas ~= nil, "t.atlas should not be nil")
    assert(t.atlas_p ~= nil, "t.atlas_position should not be nil")

    local o = Construct(self, t)

    local x, y, w, h = t.atlas_p.x, t.atlas_p.y, t.atlas_p.w or 8, t.atlas_p.h or 8
    o.quad = Love.graphics.newQuad(x, y, w, h, t.atlas.image:getDimensions())
    return o
end


function Tile:drawInCell(cell)
    self:drawInRealPos(cell:realPos())
end


function Tile:drawInRealPos(pos_real)
    Love.graphics.draw(self.atlas.image, self.quad, pos_real.x, pos_real.y, 0, self.scale)
end


return Tile

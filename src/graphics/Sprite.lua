local Tile = {
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
    local x, y = cell:pos()
    Love.graphics.draw(self.atlas.image, self.quad, x, y, 0, self.scale)
end


function Tile:drawArbitrary(top_left_x, top_left_y)
    Love.graphics.draw(self.atlas.image, self.quad, top_left_x, top_left_y, 0, self.scale)
end


return Tile

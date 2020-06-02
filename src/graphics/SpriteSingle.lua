local Sprite = require "src.graphics.Sprite"


local SpriteSingle = Sprite:new {
    atlas = nil,
    quad = nil,
}


function SpriteSingle:draw(cell)
    self:drawAtRealPos(cell:realPos())
end


function SpriteSingle:drawAtRealPos(pos_real)
    self.quad = self.quad or Love.graphics.newQuad(
        self.pos_atlas.x,
        self.pos_atlas.y,
        self.pos_atlas.w or 8,
        self.pos_atlas.h or 8,
        self.atlas:getDimensions())

    Love.graphics.draw(self.atlas, self.quad, pos_real.x, pos_real.y, 0, self.scale)
end


return SpriteSingle

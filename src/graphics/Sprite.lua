local Sprite = {
    new = Construct,
    atlas = nil,
    scale = nil,
    quad = nil,
}


function Sprite:from(atlas, texture_side, texture_scale, x, y, w, h)
    return Sprite:new {
        atlas = atlas,
        scale = texture_scale,
        quad = Love.graphics.newQuad(
            x * texture_side,
            y * texture_side,
            (w or 1) * texture_side,
            (h or 1) * texture_side,
            atlas:getDimensions()
        )
    }
end


function Sprite:draw(cell)
    self:drawAtRealPos(cell:realPos())
end


function Sprite:drawAtRealPos(pos_real)
    Love.graphics.draw(self.atlas, self.quad, pos_real.x, pos_real.y, 0, self.scale)
end


return Sprite

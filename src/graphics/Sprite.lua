local Sprite = {
    new = Construct,
    atlas = nil,
    scale = nil,
    quad = nil,
}


function Sprite:draw(cell)
    self:drawAtRealPos(cell:realPos())
end


function Sprite:drawAtRealPos(pos_real)
    Love.graphics.draw(self.atlas, self.quad, pos_real.x, pos_real.y, 0, self.scale)
end


return Sprite

local Sprite = require "src.graphics.Sprite"


local SpriteBatched = Sprite:new {
    atlas = nil,
    quad = nil,
}

function SpriteBatched:addToSpriteBatch(batch, cell)
    local image = batch:getTexture()

    local quad = Love.graphics.newQuad(
        self.pos_atlas.x,
        self.pos_atlas.y,
        self.pos_atlas.w or 8,
        self.pos_atlas.h or 8,
        image:getDimensions())

    local pos_real = cell:realPos()
    batch:add(quad, pos_real.x, pos_real.y, 0, self.scale)
end


return SpriteBatched

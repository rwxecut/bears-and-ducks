local Tile = {
    new = Construct,
    scale = nil,
    quad = nil,
}


function Tile:from(atlas, texture_side, texture_scale, x, y, w, h)
    return Tile:new {
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


return Tile

local log = Logger:new {
    component = "GraphicsLoader"
}


local GraphicsLoader = {
    new = Construct,
    path = "",
}


function GraphicsLoader:loadGraphics()
    local data = require(self.path)

    local atlases = {}
    for atl_name, atl_path in pairs(data.atlases) do
        atlases[atl_name] = Love.graphics.newImage(atl_path)
    end

    local tiles = {}
    for tile_type, tile_data in pairs(data.tiles) do
        tile_data.atlas = atlases[tile_data.atlas]
        tiles[tile_type] = tile_data
    end

    local sprites = {}
    for sprite_name, sprite_data in pairs(data.sprites) do
        local x, y, w, h = unpack(sprite_data.quad)
        sprites[sprite_name] = Sprite:new {
            atlas = atlases[sprite_data.atlas],
            scale = data.texture_scale,
            quad = Love.graphics.newQuad(
                x * data.texture_side_real,
                y * data.texture_side_real,
                (w or 1) * data.texture_side_real,
                (h or 1) * data.texture_side_real,
                atlases[sprite_data.atlas]:getDimensions()
            )
        }
    end

    return {
        texture_side_real = data.texture_side_real,
        texture_scale = data.texture_scale,
        atlases = atlases,
        tiles = tiles,
        sprites = sprites,
    }
end


return GraphicsLoader

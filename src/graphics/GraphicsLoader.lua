local log = Logger:new {
    component = "GraphicsLoader"
}


local GraphicsLoader = {
    new = Construct,
    path = "",
}


local pattern = {
    line = "(.-)\n",
    tile_size = "T (%d+)",
    atlas = "A (.+)",
    sprite = "S ([%w_]+) ([%s%d]+)"
}


function GraphicsLoader:loadSprites()
    local atlases = {}
    local sprites = {}

    local f = io.open(self.path)
    local text = f:read("*all") .. "\n"
    f:close()

    local current_tile_size
    local current_atlas_name

    for line in text:gmatch(pattern.line) do
        if line:sub(1, 1) == 'T' then
            current_tile_size = tonumber(line:match(pattern.tile_size))
            log:info("set tile size " .. current_tile_size)
        end

        if line:sub(1, 1) == 'A' then
            current_atlas_name = line:match(pattern.atlas)
            if atlases[current_atlas_name] == nil then
                atlases[current_atlas_name] = self:_createAtlas(line:match(pattern.atlas))
                log:info("loaded new atlas " .. current_atlas_name)
            else
                log:info("found cached atlas " .. current_atlas_name)
            end
        end

        if line:sub(1, 1) == 'S' then
            assert(atlases[current_atlas_name] ~= nil, "Atlas must be selected before sprite definitions.")
            local sprite_name, sprite_tiles_s = line:match(pattern.sprite)
            local sprite_tiles = self:_parseSpriteTiles(sprite_tiles_s)

            sprites[sprite_name] = self:_createSprite(atlases[current_atlas_name], sprite_tiles, current_tile_size)
            log:info("loaded sprite " .. sprite_name .. " (" .. sprite_tiles_s .. ", tile size of " .. current_tile_size .. ") from " .. current_atlas_name)
        end
    end

    return sprites
end


function GraphicsLoader:_createAtlas(path)
    return Atlas:new {path = path}
end


function GraphicsLoader:_parseSpriteTiles(sprite_tiles)
    sprite_tiles = " " .. sprite_tiles
    local nums = {}
    for str_num in sprite_tiles:gmatch(" (%d+)") do
        local num = tonumber(str_num)
        table.insert(nums, num)
    end
    local x, y, w, h = unpack(nums)

    return {
        x = x,
        y = y,
        w = w,
        h = h,
    }
end


function GraphicsLoader:_createSprite(atlas, atlas_p, tile_size)
    tile_size = tile_size or 8
    for k, v in pairs(atlas_p) do
        atlas_p[k] = v * tile_size
    end

    return Sprite:new {
        atlas = atlas,
        atlas_p = atlas_p,
    }
end


return GraphicsLoader

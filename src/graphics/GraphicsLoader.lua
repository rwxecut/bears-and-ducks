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
    atlas = "A ([%w_]+) ([%w%-%._/\\]+)",
    sprite_batchable = "S ([%w_]+) ([%s%d]+)",
    sprite_single = "C ([%w_]+) ([%w_]+) ([%s%d_]+)",
}


function GraphicsLoader:loadGraphics()
    local atlases = {}
    local sprites = {}

    local f = io.open(self.path)
    local text = f:read("*all") .. "\n"
    f:close()

    local current_tile_size

    for line in text:gmatch(pattern.line) do
        if line:sub(1, 1) == 'T' then
            current_tile_size = tonumber(line:match(pattern.tile_size))
            log:info("set tile size " .. current_tile_size)
        end

        if line:sub(1, 1) == 'A' then
            local atl_name, atl_path = line:match(pattern.atlas)
            if not atlases[atl_name] then
                log:info("making atlas " .. atl_name .. " " .. atl_path)
                atlases[atl_name] = self:_createAtlas(atl_path)
            end
        end

        if line:sub(1, 1) == 'S' then
            local sprite_name, sprite_tiles_s = line:match(pattern.sprite_batchable)
            local sprite_tiles = self:_parseSpriteTiles(sprite_tiles_s)

            log:info("making batchable sprite " .. sprite_name .. " (" .. sprite_tiles_s .. ", ts " .. current_tile_size .. ")")
            sprites[sprite_name] = self:_createSpriteBatched(sprite_tiles, current_tile_size)
        end

        if line:sub(1, 1) == 'C' then
            local sprite_atlas, sprite_name, sprite_tiles_s = line:match(pattern.sprite_single)
            local sprite_tiles = self:_parseSpriteTiles(sprite_tiles_s)

            log:info("making single sprite " .. sprite_name .. " (" .. sprite_tiles_s .. ", ts " .. current_tile_size .. ") from atlas " .. sprite_atlas)
            sprites[sprite_name] = self:_createSpriteSingle(atlases[sprite_atlas], sprite_tiles, current_tile_size)
        end
    end

    return atlases, sprites
end


function GraphicsLoader:_createAtlas(path)
    return Love.graphics.newImage(path)
end


function GraphicsLoader:_parseSpriteTiles(sprite_tiles)
    sprite_tiles = " " .. sprite_tiles
    local nums = {}
    for str_num in sprite_tiles:gmatch(" (%w+)") do
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


function GraphicsLoader:_createSpriteSingle(atlas, pos_atlas, tile_size)
    tile_size = tile_size or 8
    for k, v in pairs(pos_atlas) do
        pos_atlas[k] = v * tile_size
    end

    return SpriteSingle:new {
        atlas = atlas,
        pos_atlas = pos_atlas,
    }
end


function GraphicsLoader:_createSpriteBatched(pos_atlas, tile_size)
    tile_size = tile_size or 8
    for k, v in pairs(pos_atlas) do
        pos_atlas[k] = v * tile_size
    end

    return SpriteBatched:new {
        pos_atlas = pos_atlas,
    }
end


return GraphicsLoader

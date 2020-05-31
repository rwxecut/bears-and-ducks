local GraphicsLoader = {
    path = "",
}

GraphicsLoader.__index = GraphicsLoader


function GraphicsLoader:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end


function GraphicsLoader:loadSprites()
    local sprites = {}

    local f = io.open(self.path)
    local text = f:read("*all") .. "\n"
    f:close()

    local line_pattern = "(.-)\n"
    local file_pattern = "F (.+)"
    local sprite_pattern = "S ([%w_]+) ([%s%d]+)"

    local current_atlas

    for line in text:gmatch(line_pattern) do
        if line:sub(1, 1) == 'F' then
            local current_file = line:match(file_pattern)
            current_atlas = self:_createAtlas(current_file)
            Log.info("loaded atlas " .. current_atlas.path)
        end

        if line:sub(1, 1) == 'S' then
            local name, nums = line:match(sprite_pattern)
            sprites[name] = self:_createSprite(current_atlas, nums)
            Log.info("loaded sprite " .. name .. " (" .. nums .. ") from " .. current_atlas.path)
        end
    end

    return sprites
end


function GraphicsLoader:_createAtlas(path)
    return Atlas:new {path = path}
end

function GraphicsLoader:_createSprite(atlas, str_nums)
    str_nums = " " .. str_nums
    local nums = {}
    for str_num in str_nums:gmatch(" (%d+)") do
        local num = tonumber(str_num)
        table.insert(nums, num)
    end
    local x, y, w, h = unpack(nums)
    return Sprite:new {
        atlas = atlas,
        atlas_p = {
            x = x,
            y = y,
            w = w,
            h = h,
        }
    }
end


return GraphicsLoader

local log = Logger:new {
    component = "GameLoader"
}


local GameLoader = {
    new = Construct,
    path = "",
    grid = nil,
}


local pattern = {
    line = "(.-)\n",
    stage = "S (.+)",
    spawn = "C ([%-%s%d]+)",
    platform = "P (%w) ([%-%s%d]+)",
    stage_next = "+ (.+)",
    stage_prev = "- (.+)",
    stage_init = "I (.+)",
}


function GameLoader:loadCarousel(grid)
    local carousel = StageCarousel:new()
    local data = {}

    local f = io.open(self.path)
    local text = f:read("*all") .. "\n"
    f:close()

    for line in text:gmatch(pattern.line) do
        if line:sub(1, 1) == 'P' then
            local p_type, p_cells_s = line:match(pattern.platform)
            local p_cells = self:_parsePlatformCells(p_cells_s)
            local p = self:_createPlatform(p_type, p_cells)

            data.platforms = data.platforms or {}
            table.insert(data.platforms, p)
            log:info("loaded platorm of type " .. p_type .. " (" .. p_cells_s .. ")")
        end

        if line:sub(1, 1) == 'C' then
            local spawn_pos_s  = line:match(pattern.spawn)
            data.spawn = self:_parseSpawnPosition(spawn_pos_s)
            log:info("set spawn (" .. spawn_pos_s .. ")")
        end

        if line:sub(1, 1) == '+' then
            local stage  = line:match(pattern.stage_next)
            data.next = stage
            log:info("set next stage (" .. stage .. ")")
        end

        if line:sub(1, 1) == '-' then
            local stage  = line:match(pattern.stage_prev)
            data.prev = stage
            log:info("set prev stage (" .. stage .. ")")
        end

        if line:sub(1, 1) == 'S' then
            local stage = line:match(pattern.stage)
            carousel:set(stage, self:_createStage(data))
            data = {}

            log:info("commited data to a new stage " .. stage)
        end

        if line:sub(1, 1) == 'I' then
            local stage = line:match(pattern.stage_init)
            carousel:setCurrent(stage)

            log:info("set an initial stage " .. stage)
        end
    end

    carousel:reset()
    return carousel
end


function GameLoader:_createStage(data)
    data.grid = self.grid
    return Stage:new(data)
end


function GameLoader:_parsePlatformCells(p_cells_s)
    p_cells_s = " " .. p_cells_s
    local nums = {}
    for str_num in p_cells_s:gmatch(" (%-?%d+)") do
        local num = tonumber(str_num)
        table.insert(nums, num)
    end
    local x, y, w, h = unpack(nums)

    return {
        x = x,
        y = y,
        w = w or 1,
        h = h or 1,
    }
end


function GameLoader:_createPlatform(p_type, p_cells)
    local p = Platform:new {
        base = Cell:new {
            x = p_cells.x,
            y = p_cells.y,
        },
        type = p_type,
        width = p_cells.w,
        height = p_cells.h,
    }
    return p
end


function GameLoader:_parseSpawnPosition(spawn_pos_s)
    spawn_pos_s = " " .. spawn_pos_s
    local nums = {}
    for str_num in spawn_pos_s:gmatch(" (%-?%d+)") do
        local num = tonumber(str_num)
        table.insert(nums, num)
    end
    local x, y = unpack(nums)

    return {
        x = x,
        y = y,
    }
end


return GameLoader

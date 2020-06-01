local log = Logger:new {
    component = "GameLoader"
}


local GameLoader = {
    new = Construct,
    path = "",
}


local pattern = {
    line = "(.-)\n",
    stage = "S (.+)",
    spawn = "C ([%-%s%d%.]+)",
    platform = "P ([%-%s%d]+)",
    stage_next = "+ (.+)",
    stage_prev = "- (.+)",
    stage_init = "I (.+)",
}


function GameLoader:loadCarousel(grid)
    local carousel = StageCarousel:new {
        grid = grid
    }
    local data = {}

    local f = io.open(self.path)
    local text = f:read("*all") .. "\n"
    f:close()

    for line in text:gmatch(pattern.line) do
        if line:sub(1, 1) == 'P' then
            local p_cells_s = line:match(pattern.platform)
            local p = self:_createPlatform(p_cells_s)
            log:info("new platform (" .. p_cells_s .. ") <" .. p._id .. ">")

            if data.platform_g == nil then
                data.platform_g = PlatformGroup:new()
                log:info("new platorm group <" .. data.platform_g._id .. ">")
            end
            data.platform_g:addPlatform(p, true)
            log:info("added <" .. p._id .. "> to <" .. data.platform_g._id .. ">")
        end

        if line:sub(1, 1) == 'C' then
            local spawn_pos_s  = line:match(pattern.spawn)
            data.spawn = self:_createSpawn(spawn_pos_s)
            log:info("set spawn (" .. spawn_pos_s .. ") <" .. data.spawn._id .. ">")
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
            local stage_name = line:match(pattern.stage)
            local stage = self:_createStage(data)
            data = {}
            log:info("new stage <" .. stage._id .. "> from data")

            carousel:set(stage_name, stage)
            log:info("registered stage <" .. stage._id .. "> with name " .. stage_name)
        end

        if line:sub(1, 1) == 'I' then
            local stage = line:match(pattern.stage_init)
            carousel:setCurrent(stage)

            log:info("set initial stage " .. stage)
        end
    end

    return carousel
end


function GameLoader:_createStage(data)
    data.grid = self.grid
    data.platform_g:recalculateCells()
    return Stage:new(data)
end


function GameLoader:_createPlatform(p_cells_s)
    p_cells_s = " " .. p_cells_s
    local nums = {}
    for str_num in p_cells_s:gmatch(" (%-?%d+)") do
        local num = tonumber(str_num)
        table.insert(nums, num)
    end
    local x, y, w, h = unpack(nums)

    return Platform:new {
        pos = Vector(x, y),
        dim = Vector(w or 1, h or 1),
    }
end


function GameLoader:_createSpawn(spawn_pos_s)
    spawn_pos_s = " " .. spawn_pos_s
    local nums = {}
    for str_num in spawn_pos_s:gmatch(" (%-?%d+)") do
        local num = tonumber(str_num)
        table.insert(nums, num)
    end
    local x, y = unpack(nums)

    return Cellular:new {
        pos = Vector(x, y)
    }
end


return GameLoader

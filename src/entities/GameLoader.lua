local log = Logger:new {
    component = "GameLoader"
}

local GameLoader = {
    path = "",
    grid = nil,
}

GameLoader.__index = GameLoader


function GameLoader:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end


local pattern = {
    line = "(.-)\n",
    stage = "S (.+)",
    character = "C ([%s%d]+)",
    platform = "P (%w) ([%s%d]+)"
}


function GameLoader:loadStages(grid)
    local stages = {}

    local f = io.open(self.path)
    local text = f:read("*all") .. "\n"
    f:close()

    local current_stage_name

    for line in text:gmatch(pattern.line) do
        if line:sub(1, 1) == 'S' then
            current_stage_name = line:match(pattern.stage)
            if stages[current_stage_name] == nil then
                stages[current_stage_name] = self:_createStage(line:match(pattern.stage), self.grid)
                log:info("loaded new stage " .. current_stage_name)
            else
                log:info("found cached stage " .. current_stage_name)
            end
        end

        if line:sub(1, 1) == 'P' then
            assert(stages[current_stage_name] ~= nil, "Stage must be selected before platform definitions.")
            local p_type, p_cells_s = line:match(pattern.platform)
            local p_cells = self:_parsePlatformCells(p_cells_s)

            table.insert(stages[current_stage_name].platforms, self:_createPlatform(p_type, p_cells))
            log:info("loaded platorm of type " .. p_type .. " (" .. p_cells_s .. ") for stage " .. current_stage_name)
        end

        if line:sub(1, 1) == 'C' then
            assert(stages[current_stage_name] ~= nil, "Stage must be selected before character definition.")
            local char_pos_s  = line:match(pattern.character)
            local char_pos = self:_parseCharacterPosition(char_pos_s)

            assert(stages[current_stage_name].character == nil, "You can't add more than one character to a stage")
            stages[current_stage_name].character = self:_createCharacter(char_pos)
            log:info("loaded character (" .. char_pos_s .. ") for stage " .. current_stage_name)
        end
    end

    return stages
end


function GameLoader:_createStage(path, grid)
    return Stage:new {path = path, grid = grid}
end


function GameLoader:_parsePlatformCells(p_cells_s)
    p_cells_s = " " .. p_cells_s
    local nums = {}
    for str_num in p_cells_s:gmatch(" (%d+)") do
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
    p:addToPhys(self.phys)
    return p
end


function GameLoader:_parseCharacterPosition(char_pos_s)
    char_pos_s = " " .. char_pos_s
    local nums = {}
    for str_num in char_pos_s:gmatch(" (%d+)") do
        local num = tonumber(str_num)
        table.insert(nums, num)
    end
    local x, y = unpack(nums)

    return {
        x = x,
        y = y,
    }
end


function GameLoader:_createCharacter(char_pos)
    function char_pos:pos()
        return self.x, self.y
    end

    local c = Character:new()
    c:moveToCell(char_pos)
    c:addToPhys(self.phys)
    return c
end


return GameLoader

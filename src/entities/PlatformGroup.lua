local log = Logger:new {
    component = "PlatformGroup",
    -- enable_debug = true,
}


local pg_id_counter = 1


local PlatformGroup = {
    prefix = "platform",
    _platforms = {},
    _cells = nil, -- generated in :recalculateCells()
}


function PlatformGroup:new(t)
    local o = Construct(self, t)
    o._id = "pg" .. pg_id_counter
    pg_id_counter = pg_id_counter + 1
    return o
end


function PlatformGroup:addPlatform(p, skip_recalculation)
    Copy.localizeField(self, "_platforms")
    table.insert(self._platforms, p)

    if not skip_recalculation then
        self:recalculateCells()
    end
end


function PlatformGroup:addToPhys(phys)
    for _, p in ipairs(self._platforms) do
        p:addToPhys(phys)
    end
end


function PlatformGroup:recalculateCells()
    log:info("cell recalculation started for <" .. self._id .. ">")

    self._cells = {}
    local cs = self._cells -- alias
    for _, platform in ipairs(self._platforms) do
        for cell in platform:enumerateCells() do
            local x, y = cell.pos.x, cell.pos.y
            cs[y] = cs[y] or {}
            cs[y][x] = cs[y][x] or cell:new {
                t = false,
                b = false,
                l = false,
                r = false,
            }
        end
    end

    log:info("cell recalculation in progress for <" .. self._id .. ">")

    for i, row in pairs(cs) do
        for j, cell in pairs(row) do
            if cs[i][j-1] then
                cell.l = true
            end
            if cs[i][j+1] then
                cell.r = true
            end
            if (cs[i-1] or {})[j] then
                cell.t = true
            end
            if (cs[i+1] or {})[j] then
                cell.b = true
            end

            log:debug(("cell <%s> (%d %d %d %d) %s %s %s %s"):format(
                cell._id,
                cell.pos.x,
                cell.pos.y,
                cell.dim.x,
                cell.dim.y,
                cell.t,
                cell.b,
                cell.l,
                cell.r
            ))
        end
    end

    log:info("cell recalculation ended for <" .. self._id .. ">")
end


function PlatformGroup:draw()
    local color_before = {Love.graphics.getColor()}

    local lc
    for _, row in pairs(self._cells) do
        for _, cell in pairs(row) do
            local sprite_name = self.prefix .. "_"
            if cell.t then
                sprite_name = sprite_name .. "t"
            end
            if cell.b then
                sprite_name = sprite_name .. "b"
            end
            if cell.l then
                sprite_name = sprite_name .. "l"
            end
            if cell.r then
                sprite_name = sprite_name .. "r"
            end

            SPRITES[sprite_name]:drawInCell(cell)
            lc = cell
        end
    end

    Love.graphics.setColor(unpack(color_before))
end


return PlatformGroup

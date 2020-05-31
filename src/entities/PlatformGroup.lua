local log = Logger:new {
    component = "PlatformGroup"
}


local pg_id_counter = 1


local PlatformGroup = {
    prefix = "platform",
}


function PlatformGroup:new(t)
    local o = Construct(self, t)
    o._id = "pg" .. pg_id_counter
    pg_id_counter = pg_id_counter + 1

    o._platforms = {}
    o._cells = {}
    return o
end


function PlatformGroup:addPlatform(p, skip_recalculation)
    table.insert(self._platforms, p)

    if not skip_recalculation then
        self:recalculateCells()
    end
end


function PlatformGroup:addToPhys(phys)
    for _, p in ipairs(self._platforms) do
        log:info("<" .. self._id .. "> -- adding <" .. p._id .. "> to phys of stage <" .. phys._id .. ">")
        p:addToPhys(phys)
    end
end


function PlatformGroup:recalculateCells()
    self._cells = {}
    local cs = self._cells -- shortcut
    for _, platform in ipairs(self._platforms) do
        for cell in platform:enumerateCells() do
            local x, y = cell.x, cell.y
            cs[y] = cs[y] or {}
            cs[y][x] = cs[y][x] or cell:new {
                t = false,
                b = false,
                l = false,
                r = false,
            }
        end
    end

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
        end
    end
end


function PlatformGroup:draw()
    local color_before = {Love.graphics.getColor()}

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
        end
    end

    Love.graphics.setColor(unpack(color_before))
end


return PlatformGroup

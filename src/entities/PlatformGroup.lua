local log = Logger:new {
    component = "PlatformGroup",
}


local pg_id_counter = 1


local PlatformGroup = {
    platforms = {},
    cells = nil, -- generated in :recalculateCells()
    sprite_batch = nil, -- generated in :recalculateCells()
    transform = Love.math.newTransform()
}


function PlatformGroup:new(t)
    local o = Construct(self, t)
    o._id = "pg" .. pg_id_counter
    pg_id_counter = pg_id_counter + 1
    return o
end


function PlatformGroup:addPlatform(p, skip_recalculation)
    Copy.localizeField(self, "platforms")
    table.insert(self.platforms, p)

    if not skip_recalculation then
        self:recalculateCells()
    end
end


function PlatformGroup:addToPhys(phys)
    for _, p in ipairs(self.platforms) do
        p:addToPhys(phys)
    end
end


function PlatformGroup:recalculateCells()
    log:info("cell recalculation started for <" .. self._id .. ">")

    self.cells = {}
    local cs = self.cells -- alias
    for _, platform in ipairs(self.platforms) do
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
        end
    end

    self.sprite_batch = Love.graphics.newSpriteBatch(GRAPH.tiles.platform.atlas)
    for _, row in pairs(self.cells) do
        for _, cell in pairs(row) do
            local sprite_name = GRAPH.tiles.platform.prefix
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

            local x, y, w, h = unpack(GRAPH.tiles.platform.quads[sprite_name])
            local quad = Love.graphics.newQuad(
                x * GRAPH.texture_side_real,
                y * GRAPH.texture_side_real,
                (w or 1) * GRAPH.texture_side_real,
                (h or 1) * GRAPH.texture_side_real,
                GRAPH.tiles.platform.atlas:getDimensions())

            local cell_pos_real = cell:realPos()
            self.sprite_batch:add(quad, cell_pos_real.x, cell_pos_real.y, 0, GRAPH.texture_scale)
        end
    end

    log:info("cell recalculation ended for <" .. self._id .. ">")
end


function PlatformGroup:draw()
    local color_before = {Love.graphics.getColor()}

    Love.graphics.draw(self.sprite_batch, self.transform)

    Love.graphics.setColor(unpack(color_before))
end


return PlatformGroup

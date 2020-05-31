local Platform = Cellular:new {
    base = Cell:new {x = 0, y = 0},
    type = "w",
}


function Platform:realPos()
    return self.base:pos()
end


function Platform:draw()
    local color_before = {Love.graphics.getColor()}

    if self.width == 1 then
        SPRITES.platform:drawInCell(self.base)
    else
        for i, cell in self:_enumerateCellsLTR() do
            if i == 1 then
                SPRITES.platform_r:drawInCell(cell)
            elseif i == self.width then
                SPRITES.platform_l:drawInCell(cell)
            else
                SPRITES.platform_lr:drawInCell(cell)
            end
        end
    end

    Love.graphics.setColor(unpack(color_before))
end


function Platform:_enumerateCellsLTR()
    local i = 0
    local i_last = self.width
    return function()
        local x = self.base.x + i
        i = i + 1
        if i <= i_last then
            return i, Cell:new({x = x, y = self.base.y})
        end
    end
end


return Platform

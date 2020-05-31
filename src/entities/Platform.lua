local Platform = Cellular:new {
    base = Cell:new {x = 0, y = 0},
    type = "w",
}


function Platform:realPos()
    return self.base:pos()
end


function Platform:enumerateCells()
    local i = 0
    local i_last = self.width
    local j = 1
    local j_last = self.height
    return function()
        if i == i_last then
            j = j + 1
            i = 0
        end

        if j <= j_last then
            i = i + 1
            if i <= i_last then
                -- here 1 <= i <= i_last
                -- here 1 <= j <= j_last
                return Cell:new({x = self.base.x + i - 1, y = self.base.y + j - 1})
            end
        end
    end
end


return Platform

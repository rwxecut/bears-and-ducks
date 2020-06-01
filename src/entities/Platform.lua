local Platform = Cellular:new()


function Platform:enumerateCells()
    local i = 0
    local i_last = self.dim.x
    local j = 1
    local j_last = self.dim.y
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
                return Cellular:new {
                    pos = self.pos + Vector(i - 1, j - 1)
                }
            end
        end
    end
end


return Platform

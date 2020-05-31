local Cell = {
    new = Construct,
    size = 32,
    x = 0,
    y = 0,
}


function Cell:pos()
    return self.x * Cell.size, self.y * Cell.size
end


function Cell.nearest(x, y)
    return Cell:new {
        x = math.floor(x / Cell.size),
        y = math.floor(y / Cell.size)
    }
end


function Cell.realDistance(dist)
    return dist * Cell.size
end


function Cell.realWidth(t)
    return Cell.realDistance(t.width)
end


function Cell.realHeight(t)
    return Cell.realDistance(t.height)
end


return Cell

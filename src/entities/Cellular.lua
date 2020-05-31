local Cellular = {
    x = 0,
    y = 0,
    width = 1,
    height = 1,
}

function Cellular:new(t)
    local o = t or self
    setmetatable(o, {__index = Cellular})
    return o
end

function Cellular:realWidth()
    return Cell.realDistance(self.width)
end

function Cellular:realHeight()
    return Cell.realDistance(self.height)
end

function Cellular:realPos()
    return self.x, self.y
end

function Cellular:addToPhys(phys)
    local x, y = self:realPos()
    phys:add(self, x, y, self:realWidth(), self:realHeight())
end

return Cellular

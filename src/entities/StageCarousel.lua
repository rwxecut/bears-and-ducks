local log = Logger:new {
    component = "StageCarousel"
}


local StageCarousel = {
    grid = Grid:new(),
    stages = {},
    current = ""
}


function StageCarousel:new(t)
    local o = Construct(self, t)
    return o
end


function StageCarousel:set(name, s)
    Copy.localizeField(self, "stages")
    self.stages[name] = s
end


function StageCarousel:setCurrent(name)
    self.current = name
end


function StageCarousel:getCurrent()
    return self.stages[self.current]
end


function StageCarousel:reset()
    Copy.localizeField(self, "stages")
    self.stages[self.current]:reset()
end


function StageCarousel:draw(camera)
    self.grid:draw(camera)
    self.stages[self.current]:draw(camera)
end


function StageCarousel:next()
    local next = self.stages[self.current].next
    log:info(":next(); self.current = " .. self.current .. ", next = " .. (next or "nil"))
    if next ~= nil then
        self.current = next
        self:reset()
    end
end


function StageCarousel:prev()
    local prev = self.stages[self.current].prev
    log:info(":prev(); self.current = " .. self.current .. ", prev = " .. (prev or "nil"))
    if prev ~= nil then
        self.current = prev
        self:reset()
    end
end


return StageCarousel

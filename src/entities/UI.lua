local UI = {
    show_fps = false
}

UI.__index = UI

function UI:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end

function UI:draw()
    if self.show_fps then
        Love.graphics.print(tostring(Love.timer.getFPS( )).." FPS", 10, 10)
    end
end

return UI

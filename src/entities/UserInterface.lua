local UserInterface = {
    new = Construct,
    show_fps = false,
    show_coordinates = false,
}


function UserInterface:draw()
    if self.show_fps then
        Love.graphics.print(tostring(Love.timer.getFPS()) .. " FPS", 10, 10)
    end
    if self.show_coordinates then
        local char = SC:getCurrent().character
        Love.graphics.print(string.format("x: %.2f, y: %.2f", char.x, char.y), 10, 30)
    end
end


return UserInterface

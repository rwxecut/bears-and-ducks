local UserInterface = {
    new = Construct,
    show_help = false,
    show_performance = false,
    show_char_info = false,
    show_char_collisions = false,
}


function UserInterface:draw()
    local line = 10
    if self.show_help and self.help then
        Love.graphics.print(self.help, 10, line)
        line = line + 20
    end
    if self.show_performance then
        Love.graphics.print(("%d FPS"):format(Love.timer.getFPS()), 10, line)
        line = line + 20
    end
    if self.show_char_info then
        local char = SC:getCurrent().character
        Love.graphics.print(("char vel: x: %.2f, y: %.2f"):format(char.vel.x, char.vel.y), 10, line)
        line = line + 20
        Love.graphics.print(("char pos: x: %.2f, y: %.2f"):format(char.pos.x, char.pos.y), 10, line)
        line = line + 20
    end
    if self.show_char_collisions and self.c and self.c_len then
        for i = 1, self.c_len do
            local col = self.c[i].other
            Love.graphics.print(
                ("char collides with <%s> (%d %d %d %d)"):format(col._id, col.pos.x, col.pos.y, col.dim.x, col.dim.y),
                10,
                line)
            line = line + 20
        end
    end
end


return UserInterface

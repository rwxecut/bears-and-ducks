local UserInterface = {
    new = Construct,
    show_fps = false,
    show_char_vel = false,
    show_char_pos_tile = false,
    show_char_pos_real = false,
    show_collisions = false,
    show_help = false,
}


function UserInterface:draw()
    local line = 10
    if self.show_help and self.help then
        Love.graphics.print(self.help, 10, line)
        line = line + 20
    end
    if self.show_fps then
        Love.graphics.print(("%d FPS"):format(Love.timer.getFPS()), 10, line)
        line = line + 20
    end
    if self.show_char_vel then
        local char = SC:getCurrent().character
        Love.graphics.print(("char vel tile: x: %.2f, y: %.2f"):format(char.vel.x, char.vel.y), 10, line)
        line = line + 20
    end
    if self.show_char_pos_tile then
        local char = SC:getCurrent().character
        Love.graphics.print(("char pos tile: x: %.2f, y: %.2f"):format(char.pos.x, char.pos.y), 10, line)
        line = line + 20
    end
    if self.show_char_pos_real then
        local char = SC:getCurrent().character
        local pos_real = char:realPos()
        Love.graphics.print(("char pos real: x: %.2f, y: %.2f"):format(pos_real.x, pos_real.y), 10, line)
        line = line + 20
    end
    if self.show_collisions and self.c and self.c_len then
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

local function keypressed(key)
    if key == "q" then
        CAM:rotateClockwise()
    elseif key == "w" then
        CAM:rotateCounterclockwise()
    elseif key == "[" then
        SC:prev()
    elseif key == "]" then
        SC:next()
    elseif key == "d" then
        SC.grid.show_pos = not SC.grid.show_pos
    elseif key == "j" then
        KB.pressed_j = true
    end
end


local function keyreleased(key)
    if key == "j" then
        KB.pressed_j = false
    end
end


return {
    keypressed = keypressed,
    keyreleased = keyreleased,
}

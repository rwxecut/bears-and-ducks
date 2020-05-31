local function keypressed(key)
    if key == "q" then
        CAM:rotateClockwise()
    elseif key == "w" then
        CAM:rotateCounterclockwise()
    elseif key == "[" then
        SC:prev()
    elseif key == "]" then
        SC:next()
    end
end


local function keyreleased(key)

end


return {
    keypressed = keypressed,
    keyreleased = keyreleased,
}

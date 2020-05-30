local function keypressed(key)
  if key == "q" then CAM:rotate(math.pi / 12)
  elseif key == "w" then CAM:rotate(-math.pi / 12)
  end
end


local function keyreleased(key)

end


return {
    keypressed = keypressed,
    keyreleased = keyreleased,
}

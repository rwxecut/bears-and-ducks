local function keypressed(key)
  if key == "q" then CHAR.camera:rotate(math.pi / 18)
  elseif key == "w" then CHAR.camera:rotate(-math.pi / 18)
  end
end


local function keyreleased(key)

end


return {
    keypressed = keypressed,
    keyreleased = keyreleased,
}

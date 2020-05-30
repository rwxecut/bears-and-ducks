Love = love
Camera = require "deps.hump.camera"

local functions = require "src.init"

for key, value in pairs(functions) do
    Love[key] = value
end

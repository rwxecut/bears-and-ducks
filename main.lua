Love = love
Camera = require "deps.hump.camera"

if not unpack then
    unpack = table.unpack
end

local functions = require "src.init"

for key, value in pairs(functions) do
    Love[key] = value
end

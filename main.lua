Love = love
Camera = require "deps.hump.camera"
Vector = require "deps.hump.vector"
Bump = require "deps.bump.bump"

if not unpack then
    unpack = table.unpack
end

local functions = require "src.init"

for key, value in pairs(functions) do
    print(string.format("set love.%s = %s", key, tostring(value)))
    Love[key] = value
end

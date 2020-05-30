local init = require "src.init"

local functions = init(love)

for key, value in pairs(functions) do
    love[key] = value
end
